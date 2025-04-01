//
//  EditNameCell.swift
//  GroceryList
//
//  Created by Kristina Cherevko on 4/1/25.
//

import UIKit

protocol EditNameCellDelegate: AnyObject {
    func toggleIsFavorite()
    func editName(with newName: String)
}
class EditNameCell: UITableViewCell {
    weak var delegate: EditNameCellDelegate?
    
    let nameTextField: UITextField = {
        let field = UITextField()
        field.font = .systemFont(ofSize: 16)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let favoritesButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "star")
        configuration.baseForegroundColor = .systemGray
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        isUserInteractionEnabled = true
        contentView.addSubview(nameTextField)
        contentView.addSubview(favoritesButton)
        favoritesButton.addTarget(self, action: #selector(toggleIsFavorite), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
//            nameTextField.trailingAnchor.constraint(equalTo: favoritesButton.leadingAnchor),
            favoritesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            favoritesButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            favoritesButton.widthAnchor.constraint(equalToConstant: 24),
            favoritesButton.heightAnchor.constraint(equalToConstant: 24),
        ])
    }

    func configure(with name: String, isFavorite: Bool) {
        print("configuring")
        nameTextField.text = name
        favoritesButton.setImage(isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
        favoritesButton.configuration?.baseForegroundColor = isFavorite ? .amber : .systemGray
        
    }
    
    @objc func toggleIsFavorite() {
        print("toggled favorite")
        delegate?.toggleIsFavorite()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
}
