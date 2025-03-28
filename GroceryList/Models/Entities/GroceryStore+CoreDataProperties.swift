//
//  GroceryStore+CoreDataProperties.swift
//  GroceryList
//
//  Created by Kristina Cherevko on 3/25/25.
//
//

import Foundation
import CoreData


extension GroceryStore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroceryStore> {
        return NSFetchRequest<GroceryStore>(entityName: "GroceryStore")
    }

    @NSManaged public var name: String
    @NSManaged public var id: UUID
    @NSManaged public var shopItems: NSSet?

}

// MARK: Generated accessors for shopItems
extension GroceryStore {

    @objc(addShopItemsObject:)
    @NSManaged public func addToShopItems(_ value: GroceryItem)

    @objc(removeShopItemsObject:)
    @NSManaged public func removeFromShopItems(_ value: GroceryItem)

    @objc(addShopItems:)
    @NSManaged public func addToShopItems(_ values: NSSet)

    @objc(removeShopItems:)
    @NSManaged public func removeFromShopItems(_ values: NSSet)

}

extension GroceryStore : Identifiable {
    

}
