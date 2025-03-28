//
//  SuggestionsViewModel.swift
//  GroceryList
//
//  Created by Kristina Cherevko on 3/26/25.
//

class SuggestionsViewModel {
    var foodItemManager = FoodItemManager()
    var foodItems: [FoodItem] = []
    var filteredFoodItems: [FoodItem] = []
    
    var onDataUpdated: (() -> Void)?
    init() {
        loadFoodItems()
    }
    
    func loadFoodItems() {
        let foodItems = foodItemManager.getAllFoodItems()
        self.foodItems = foodItems
        self.filteredFoodItems = foodItems
//        print(foodItems)
        onDataUpdated?()
    }
    
    func filterFoodItems(matching query: String) {
        if query.isEmpty {
            filteredFoodItems = foodItems
        } else {
            filteredFoodItems = foodItems.filter { $0.name.lowercased().contains(query.lowercased()) }
        }
//        print(filteredFoodItems)
        onDataUpdated?()
    }
}
