//
//  AppCoordinator.swift
//  GroceryList
//
//  Created by Kristina Cherevko on 3/28/25.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let groceryListVC = GroceryListViewController()
        groceryListVC.delegate = self
        navigationController.pushViewController(groceryListVC, animated: true)
    }
    
    
}

extension AppCoordinator: GroceryListViewControllerDelegate {
    func didTapGroceryItem(_ item: GroceryItem) {
        let viewModel = EditGroceryItemViewModel(groceryItem: item)
        let editGroceryItemVC = EditGroceryItemViewController()
        editGroceryItemVC.viewModel = viewModel
        navigationController.pushViewController(editGroceryItemVC, animated: true)
    }
    
    func didTapFavoritesButton() {
        
    }
    
    func didTapRecentItemsButton() {
        
    }
    
    func didTapBoughtItemsButton() {
        
    }
    
    func didTapShareButton() {
        
    }
    
    
}
