//
//  FoodItem+CoreDataProperties.swift
//  GroceryList
//
//  Created by Kristina Cherevko on 3/24/25.
//
//

import Foundation
import CoreData


extension FoodItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodItem> {
        return NSFetchRequest<FoodItem>(entityName: "FoodItem")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var category: Category

}

extension FoodItem : Identifiable {

}
