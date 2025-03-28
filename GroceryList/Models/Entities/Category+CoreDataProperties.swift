//
//  Category+CoreDataProperties.swift
//  GroceryList
//
//  Created by Kristina Cherevko on 3/24/25.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var createdAt: Date
    @NSManaged public var foodItems: NSSet?
    @NSManaged public var groceryItems: NSSet?

}

// MARK: Generated accessors for foodItems
extension Category {

    @objc(addFoodItemsObject:)
    @NSManaged public func addToFoodItems(_ value: FoodItem)

    @objc(removeFoodItemsObject:)
    @NSManaged public func removeFromFoodItems(_ value: FoodItem)

    @objc(addFoodItems:)
    @NSManaged public func addToFoodItems(_ values: NSSet)

    @objc(removeFoodItems:)
    @NSManaged public func removeFromFoodItems(_ values: NSSet)

}

// MARK: Generated accessors for groceryItems
extension Category {

    @objc(addGroceryItemsObject:)
    @NSManaged public func addToGroceryItems(_ value: GroceryItem)

    @objc(removeGroceryItemsObject:)
    @NSManaged public func removeFromGroceryItems(_ value: GroceryItem)

    @objc(addGroceryItems:)
    @NSManaged public func addToGroceryItems(_ values: NSSet)

    @objc(removeGroceryItems:)
    @NSManaged public func removeFromGroceryItems(_ values: NSSet)

}

extension Category : Identifiable, Comparable {
    public static func < (lhs: Category, rhs: Category) -> Bool {
        return lhs.name < rhs.name
    }

}
