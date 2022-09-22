//
//  CategoryCell.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 22/09/2022.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    static let identifier = String(describing: CategoryCell.self)
    
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        backgroundColor = .red
        
        addSubview(nameLabel)
        nameLabel.setConstraints(top: topAnchor,
                             leading: leadingAnchor,
                             trailing: trailingAnchor,
                             bottom: nil)
    }
    
    func configure(name: String) {
        nameLabel.text = name
    }
}
