//
//  Coordinator.swift
//  GroceryList
//
//  Created by Kristina Cherevko on 3/26/25.
//

import UIKit

protocol Coordinator: AnyObject {
    // nav controller to manage navigation stack
    var navigationController: UINavigationController { get set }
    // method to start the flow managed by coordinator
    func start()
}
