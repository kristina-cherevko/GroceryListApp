//
//  EditGroceryItemViewController.swift
//  GroceryList
//
//  Created by Kristina Cherevko on 3/28/25.
//

import UIKit

class EditGroceryItemViewController: UIViewController {
    var viewModel: EditGroceryItemViewModel!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Edit Item"
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        setupBarButtons()
        setupUI()
    }
    
    func setupBarButtons() {
        let leftBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(closeVC))
        let rightBarButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(saveChanges))
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func setupUI() {
        tableView = UITableView.init(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EditNameCell.self, forCellReuseIdentifier: CellIdentifiers.editNameCell)
        tableView.register(EditInfoCell.self, forCellReuseIdentifier: CellIdentifiers.editInfoCell)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    @objc func closeVC() {
        dismiss(animated: true)
    }
    
    @objc func saveChanges() {
        print("saving changes")
        dismiss(animated: true)
    }

}

extension EditGroceryItemViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        if indexPath.section == 0 {
    
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.editNameCell, for: indexPath) as! EditNameCell
            cell.configure(with: viewModel.name, isFavorite: viewModel.isFavorite)
            cell.delegate = viewModel
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.editInfoCell, for: indexPath) as! EditInfoCell
            if indexPath.row == 0 {
                cell.configure(with: viewModel.category)
            } else {
                cell.configure(with: viewModel.store)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
