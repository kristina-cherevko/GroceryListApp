//
//  CoreDataManager.swift
//  GroceryList
//
//  Created by Kristina Cherevko on 3/24/25.
//

import Foundation
import CoreData
import UIKit

class GroceryItemManager {
    private let coreDataManager = CoreDataManager.shared

    func addGroceryItem(name: String, category: Category) -> GroceryItem {
        let newItem = GroceryItem(context: coreDataManager.context)
        newItem.id = UUID()
        newItem.name = name
        newItem.category = category
        newItem.isBought = false
        newItem.createdAt = Date()
        coreDataManager.saveContext()
        return newItem
    }
    
    func getAllGroceryItems() -> [GroceryItem] {
        let fetchRequest: NSFetchRequest<GroceryItem> = GroceryItem.fetchRequest()
        return (try? coreDataManager.context.fetch(fetchRequest)) ?? []
    }
    
    func getGroceryItems(for category: Category) -> [GroceryItem] {
        let fetchRequest: NSFetchRequest<GroceryItem> = GroceryItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "category == %@", category)
        return (try? coreDataManager.context.fetch(fetchRequest)) ?? []
    }
    
    func updateGroceryItemStatus(_ item: GroceryItem, isBought: Bool) {
        item.isBought = isBought
        coreDataManager.saveContext()
    }
    
    func deleteGroceryItem(_ item: GroceryItem) {
        coreDataManager.context.delete(item)
        coreDataManager.saveContext()
    }
}
