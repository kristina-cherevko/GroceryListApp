//
//  PreloadDataManager.swift
//  GroceryList
//
//  Created by Kristina Cherevko on 3/24/25.
//

import Foundation
import UIKit
import CoreData

class PreloadDataManager {
    
    private let coreDataManager = CoreDataManager.shared
    
    private let categoryManager = CategoryManager()
    private let foodItemsManager = FoodItemManager()
    // Function to preload data only once (on the first launch)
    func preloadDataIfNeeded() {
        // Check if preload has been done before
        if isPreloadDone() {
            return // If preload is done, no need to preload again
        }
        
        // Proceed with preload if it hasn't been done yet
        preloadData()
        
        // Mark preload as done by setting a flag in UserDefaults
        markPreloadDone()
    }
    
    // Check if preload has been done (using UserDefaults)
    private func isPreloadDone() -> Bool {
        return UserDefaults.standard.bool(forKey: "hasPreloadedData")
    }
    
    // Set flag in UserDefaults to indicate that preload has been done
    private func markPreloadDone() {
        UserDefaults.standard.set(true, forKey: "hasPreloadedData")
    }
    
    private func preloadData() {
        guard let url = Bundle.main.url(forResource: "predefinedData", withExtension: "json") else {
            print("Predefined data file not found!")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let predefinedData = try decoder.decode(PredefinedData.self, from: data)
            
            // Preload the categories and food items
            preloadCategories(from: predefinedData)
            
            // Save the context after adding the data
            coreDataManager.saveContext()
            
        } catch {
            print("Error loading or parsing predefined data: \(error)")
        }
    }

    // Function to preload categories and food items
    private func preloadCategories(from predefinedData: PredefinedData) {
        for categoryData in predefinedData.categories {
            createCategory(from: categoryData)
        }
    }

    // Function to create a category in Core Data
    private func createCategory(from categoryData: CategoryData) {
        let category = categoryManager.addCategory(name: categoryData.name)
        // Create food items for the category
        preloadFoodItems(for: category, from: categoryData.foodItems)
    }

    // Function to preload food items for a category
    private func preloadFoodItems(for category: Category, from foodItemsData: [FoodItemData]) {
        for foodItemData in foodItemsData {
            let _ = foodItemsManager.addFoodItem(name: foodItemData.name, category: category)
        }
    }


}
