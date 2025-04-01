//
//  BackgroundSupplementaryView.swift
//  GroceryList
//
//  Created by Kristina Cherevko on 4/1/25.
//

import UIKit

final class BackgroundSupplementaryView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 8
        backgroundColor = UIColor(white: 0.9, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
