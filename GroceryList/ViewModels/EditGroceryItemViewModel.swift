//
//  EditGroceryItemViewModel.swift
//  GroceryList
//
//  Created by Kristina Cherevko on 3/28/25.
//

import Foundation

enum GroceryItemSection {
    case name(EditNameCellModel)
    case details([EditInfoCellModel])
    
    var title: String {
        switch self {
        case .name:
            return ""
        case .details:
            return "Details"
        }
    }
    
    var cells: [Any] {
        switch self {
        case .name(let cell):
            return [cell]
        case .details(let cells):
            return cells
        }
    }
}

// Cell Model for Name & Favorite
struct EditNameCellModel {
    let name: String
    let isFavorite: Bool
}

// Cell Model for Store & Category
struct EditInfoCellModel {
    let title: String
    let value: String
}

class EditGroceryItemViewModel {
    var name: String
    var category: Category
    var store: GroceryStore?
    var isFavorite: Bool
    
//    var sections: [GroceryItemSection] = []
    var reloadData: (() -> Void)?
    
    init(groceryItem: GroceryItem) {
        self.name = groceryItem.name
        self.category = groceryItem.category
        self.store = groceryItem.store
        self.isFavorite = groceryItem.isFavorite
    }
  
}

extension EditGroceryItemViewModel: EditNameCellDelegate {
    func toggleIsFavorite() {
        self.isFavorite.toggle()
        print(isFavorite)
        reloadData?()
    }
    
    func editName(with newName: String) {
        self.name = newName
        reloadData?()
    }
    
    
}
