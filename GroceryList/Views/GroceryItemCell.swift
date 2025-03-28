//
//  GroceryItemCell.swift
//  GroceryList
//
//  Created by Kristina Cherevko on 3/24/25.
//

import UIKit

protocol GroceryItemCellDelegate: AnyObject {
    func didToggleCheckmark(for groceryItem: GroceryItem?)
}

class GroceryItemCell: UICollectionViewCell {
    weak var delegate: GroceryItemCellDelegate?
    var item: GroceryItem?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle") // SF Symbol
        imageView.tintColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(nameLabel)
        contentView.addSubview(checkmarkImageView)
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: checkmarkImageView.trailingAnchor, constant: 8),
            
            checkmarkImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: 24),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.textColor = .label
    }
    
    func configure(with item: GroceryItem) {
        self.item = item
        nameLabel.text = item.name
        checkmarkImageView.image = item.isBought ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


