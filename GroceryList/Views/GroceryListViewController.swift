//
//  ViewController.swift
//  GroceryList
//
//  Created by Kristina Cherevko on 3/24/25.
//

import UIKit

protocol GroceryListViewControllerDelegate: AnyObject {
    func didTapGroceryItem(_ item: GroceryItem)
    func didTapFavoritesButton()
    func didTapRecentItemsButton()
    func didTapBoughtItemsButton()
    func didTapShareButton()
}

class GroceryListViewController: UIViewController {
    private let viewModel = GroceryListViewModel()
    private let suggestionsViewModel = SuggestionsViewModel()
    weak var delegate: GroceryListViewControllerDelegate?
    private var collectionView: UICollectionView!
    
    // Store current search text
    private var currentSearchText: String = ""
    
    let favoritesButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "star.fill")
        configuration.baseForegroundColor = .amber
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 24).isActive = true
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return button
    }()
    
    let recentAddedButton: UIButton = {
       let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "clock")
        configuration.baseForegroundColor = .crayola
        button.configuration = configuration
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let showBoughtButton: UIButton = {
       let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "eye")
        configuration.baseForegroundColor = .crayola
        button.configuration = configuration
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var suggestionsTableView: UITableView!
    private var searchController = UISearchController(searchResultsController: nil)
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBarButtonItems()
        setupSearchController()
        setupSuggestionsTable()
        viewModel.getGroceryItems()
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        suggestionsViewModel.onDataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.suggestionsTableView.reloadData()
            }
        }
    }

    private func setupUI() {
        title = "My Grocery List"
        view.backgroundColor = .systemBackground
 
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GroceryItemCell.self, forCellWithReuseIdentifier: CellIdentifiers.groceryItemCell)
        collectionView.register(CategoryHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CellIdentifiers.categoryHeaderView)
    }
    
    private func setupBarButtonItems() {
//        let showBoughtButton = UIBarButtonItem(image: UIImage(systemName: "eye"), style: .plain, target: self, action: #selector(showBoughtButtonTapped))
//        showBoughtButton.tintColor = .systemBlue
        
        let stackView = UIStackView(arrangedSubviews: [favoritesButton, recentAddedButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        let leftBarButton = UIBarButtonItem(customView: stackView)
        navigationItem.leftBarButtonItem = leftBarButton
        
        let rightBarButton = UIBarButtonItem(customView: showBoughtButton)
        navigationItem.rightBarButtonItem = rightBarButton
    }

    private func setupSuggestionsTable() {
        suggestionsTableView = UITableView(frame: .zero, style: .plain)
        suggestionsTableView.translatesAutoresizingMaskIntoConstraints = false
        suggestionsTableView.dataSource = self
        suggestionsTableView.delegate = self
        suggestionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifiers.suggestionCell)
        suggestionsTableView.isHidden = true
        view.addSubview(suggestionsTableView)
        
        NSLayoutConstraint.activate([
            suggestionsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), // adjust as needed
            suggestionsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            suggestionsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            suggestionsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor) // adjust height or use dynamic sizing
        ])
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [
                NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            ]
            return section
        }
        return layout
    }
    
    private func setupSearchController() {
        searchController.searchBar.placeholder = "Add Item"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.setValue("Done", forKey: "cancelButtonText")
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
        navigationItem.preferredSearchBarPlacement = .inline
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    @objc private func favoritesButtonTapped() {
        print("favorites tapped")
    }
    
    @objc private func recentAddedButtonTapped() {
        print("favorites tapped")
    }
    
    @objc private func showBoughtButtonTapped() {
        print("favorites tapped")
    }
}

extension GroceryListViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        currentSearchText = searchText
        suggestionsViewModel.filterFoodItems(matching: searchText)
        suggestionsTableView.isHidden = searchText.isEmpty || suggestionsViewModel.filteredFoodItems.isEmpty
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(currentSearchText)
        if !currentSearchText.isEmpty {
            viewModel.addGroceryItem(name: currentSearchText, category: nil)
        }
        currentSearchText = ""
        searchBar.text = ""
        searchController.isActive = false
        suggestionsTableView.isHidden = true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
       navigationItem.leftBarButtonItem = nil
       navigationItem.rightBarButtonItems = nil
       self.searchController.searchBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44)
       
   }
   
   func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
       setupBarButtonItems()
       self.searchController.searchBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width * 0.7, height: 44)
       
   }
}

// MARK: - UITableView DataSource & Delegate
extension GroceryListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestionsViewModel.filteredFoodItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.suggestionCell, for: indexPath)
        cell.textLabel?.text = suggestionsViewModel.filteredFoodItems[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedSuggestion = suggestionsViewModel.filteredFoodItems[indexPath.row]
        print(selectedSuggestion)
        viewModel.addGroceryItem(name: selectedSuggestion.name, category: selectedSuggestion.category)
        searchController.isActive = false
        tableView.isHidden = true
    }
}


extension GroceryListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.categories.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let category = viewModel.categories[section]
        return viewModel.items(for: category).count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.groceryItemCell, for: indexPath) as! GroceryItemCell
        let category = viewModel.categories[indexPath.section]
        let items = viewModel.items(for: category)
        let item = items[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = viewModel.categories[indexPath.section]
        let items = viewModel.items(for: category)
        let item = items[indexPath.row]
        viewModel.toggleItemBoughtStatus(item)
        collectionView.reloadItems(at: [indexPath])
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CellIdentifiers.categoryHeaderView, for: indexPath) as! CategoryHeaderView
        let category = viewModel.categories[indexPath.section]
        header.configure(with: category.name)
        return header
    }
}

