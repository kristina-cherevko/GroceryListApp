//
//  EditGroceryItemViewController.swift
//  GroceryList
//
//  Created by Kristina Cherevko on 3/28/25.
//

import UIKit

class EditGroceryItemViewController: UIViewController {
    var viewModel: EditGroceryItemViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Edit Item"
        setupBarButtons()
    }
    
    func setupBarButtons() {
        let leftBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(closeVC))
        let rightBarButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(saveChanges))
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }

    @objc func closeVC() {
        dismiss(animated: true)
    }
    
    @objc func saveChanges() {
        print("saving changes")
        dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
