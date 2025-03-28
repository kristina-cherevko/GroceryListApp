//
//  GroceryItem+CoreDataProperties.swift
//  GroceryList
//
//  Created by Kristina Cherevko on 3/25/25.
//
//

import Foundation
import CoreData


extension GroceryItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroceryItem> {
        return NSFetchRequest<GroceryItem>(entityName: "GroceryItem")
    }

    @NSManaged public var isBought: Bool
    @NSManaged public var isFavorite: Bool
    @NSManaged public var createdAt: Date
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var category: Category
    @NSManaged public var store: GroceryStore?

}

extension GroceryItem : Identifiable, Comparable {
    public static func < (lhs: GroceryItem, rhs: GroceryItem) -> Bool {
        return lhs.name < rhs.name
    }
    

}
