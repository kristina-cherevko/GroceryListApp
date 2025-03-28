//
//  CategoryManager.swift
//  GroceryList
//
//  Created by Kristina Cherevko on 3/24/25.
//

import Foundation
import CoreData
import UIKit

class CategoryManager {
    private let coreDataManager = CoreDataManager.shared

    func addCategory(name: String) -> Category {
        let category = Category(context: coreDataManager.context)
        category.id = UUID()
        category.name = name
        category.createdAt = Date()
        coreDataManager.saveContext()
        return category
    }
    
    func getAllCategories() -> [Category] {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            return try coreDataManager.context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch categories: \(error)")
            return []
        }
    }
    
    func fetchCategoryByName(_ name: String) -> Category? {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        return try? coreDataManager.context.fetch(fetchRequest).first
    }
    
    func deleteCategory(_ category: Category) {
        coreDataManager.context.delete(category)
        coreDataManager.saveContext()
    }
}
