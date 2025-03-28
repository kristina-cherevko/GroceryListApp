//
//  PredefinedData.swift
//  GroceryList
//
//  Created by Kristina Cherevko on 3/24/25.
//


struct PredefinedData: Decodable {
    let categories: [CategoryData]
}

struct CategoryData: Decodable {
    let name: String
    let foodItems: [FoodItemData]
}

struct FoodItemData: Decodable {
    let name: String
}
