//
//  FoodItemManager.swift
//  FoodList
//
//  Created by Kristina Cherevko on 3/24/25.
//

import Foundation
import UIKit
import CoreData

class FoodItemManager {
    
    private let coreDataManager = CoreDataManager.shared
    private let categoryManager = CategoryManager()
    
    func addFoodItem(name: String, category: Category? = nil) -> FoodItem {
        let categoryToUse = category ?? categoryManager.fetchCategoryByName("Other")!
        
        if let existingFoodItem = getFoodItemByName(name) {
            print("Food item \(existingFoodItem.name) already exists.")
            return existingFoodItem
        }
        
        let newFoodItem = FoodItem(context: coreDataManager.context)
        newFoodItem.id = UUID()
        newFoodItem.name = name
        newFoodItem.category = categoryToUse
        coreDataManager.saveContext()
        return newFoodItem
    }
    
    func getAllFoodItems() -> [FoodItem] {
        let fetchRequest: NSFetchRequest<FoodItem> = FoodItem.fetchRequest()
        return (try? coreDataManager.context.fetch(fetchRequest)) ?? []
    }
    
    func getFoodItems(for category: Category) -> [FoodItem] {
        let fetchRequest: NSFetchRequest<FoodItem> = FoodItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "category == %@", category)
        return (try? coreDataManager.context.fetch(fetchRequest)) ?? []
    }
    
    func getFoodItemByName(_ name: String) -> FoodItem? {
        let fetchRequest: NSFetchRequest<FoodItem> = FoodItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        return try? coreDataManager.context.fetch(fetchRequest).first
    }
    
    func deleteFoodItem(_ item: FoodItem) {
        coreDataManager.context.delete(item)
        coreDataManager.saveContext()
    }
}
