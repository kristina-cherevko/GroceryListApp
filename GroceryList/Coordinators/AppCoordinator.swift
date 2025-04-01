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
        print("tapped grocery item \(item.name)")
        let viewModel = EditGroceryItemViewModel(groceryItem: item)
        let editGroceryItemVC = EditGroceryItemViewController()
        editGroceryItemVC.viewModel = viewModel
        let navController = UINavigationController(rootViewController: editGroceryItemVC)
        editGroceryItemVC.modalPresentationStyle = .formSheet
            
        
        navigationController.present(navController, animated: true, completion: nil)
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
