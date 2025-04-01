//
//  GroceryItemCell.swift
//  GroceryList
//
//  Created by Kristina Cherevko on 3/24/25.
//

import UIKit

protocol GroceryItemCellDelegate: AnyObject {
    func didTapCheckmark(for item: GroceryItem)
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
    
    private let checkmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.tintColor = .systemGray4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        contentView.addSubview(nameLabel)
        contentView.addSubview(checkmarkButton)
        checkmarkButton.addTarget(self, action: #selector(handleCheckmarkToggle), for: .touchUpInside)
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: checkmarkButton.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            checkmarkButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkmarkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            checkmarkButton.widthAnchor.constraint(equalToConstant: 24),
            checkmarkButton.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.textColor = .label
    }
    
    private func setupUI() {
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.75
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 20
        layer.masksToBounds = false
    }
    
    func configure(with item: GroceryItem) {
        self.item = item
        nameLabel.text = item.name
        let imageName = item.isBought ? "checkmark.circle.fill" : "circle"
        checkmarkButton.setImage(UIImage(systemName: imageName), for: .normal)
        checkmarkButton.tintColor = item.isBought ? .kellyGreen : .systemGray4
    }
    
    @objc func handleCheckmarkToggle() {
        guard let item = item else { return }
        delegate?.didTapCheckmark(for: item)
    }
}


