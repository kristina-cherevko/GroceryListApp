//
//  EditGroceryItemViewModel.swift
//  GroceryList
//
//  Created by Kristina Cherevko on 3/28/25.
//

import Foundation

class EditGroceryItemViewModel {
    var name: String
    var category: Category
    var store: GroceryStore?
    var isFavorite: Bool
    
    init(groceryItem: GroceryItem) {
        self.name = groceryItem.name
        self.category = groceryItem.category
        self.store = groceryItem.store
        self.isFavorite = groceryItem.isFavorite
    }
    
    
}
