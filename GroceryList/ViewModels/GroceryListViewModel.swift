//
//  GroceryListViewModel.swift
//  GroceryList
//
//  Created by Kristina Cherevko on 3/24/25.
//

import Foundation

class GroceryListViewModel {
    private let groceryItemManager = GroceryItemManager()
    private let categoryManager = CategoryManager()
    
    var groceryItems: [GroceryItem] = []
    var categories: [Category] = []

    var reloadData: (() -> Void)?
    
    init() {
        getGroceryItems()
    }
    
    func getGroceryItems() {
        groceryItems = groceryItemManager.getAllGroceryItems()
        categories = Array(Set(groceryItems.compactMap { $0.category })).sorted(by: {$0.name < $1.name})
        reloadData?()
    }
    
    func items(for category: Category) -> [GroceryItem] {
        return groceryItems.filter { $0.category == category }
    }
    
 
    
    func addGroceryItem(name: String, category: Category? = nil) {
        guard let category = category ?? categoryManager.fetchCategoryByName("Other") else { return }
        let newGroceryItem = groceryItemManager.addGroceryItem(name: name, category: category)
        groceryItems.append(newGroceryItem)
         // Optionally update categories if this category isn’t already in the list.
         if !categories.contains(where: { $0.id == category.id }) { // Assuming Category has an "id"
             categories.append(category)
         }
        reloadData?()
    }
    
}

extension GroceryListViewModel: GroceryItemCellDelegate {
    func didTapCheckmark(for item: GroceryItem) {
        groceryItemManager.updateGroceryItemStatus(item, isBought: !item.isBought)
        reloadData?()
    }
    
    
}
