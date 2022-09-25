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
    let imageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        backgroundColor = .white
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        addSubview(imageView)
        imageView.setConstraints(top: topAnchor,
                                 leading: leadingAnchor,
                                 trailing: trailingAnchor,
                                 bottom: bottomAnchor)
        
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: Constants.boldFontName, size: 20)
        addSubview(nameLabel)
        nameLabel.setConstraints(top: nil,
                             leading: leadingAnchor,
                             trailing: trailingAnchor,
                             bottom: bottomAnchor,
        padding: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10))
    }
    
    func configure(category: LBCCategory) {
        nameLabel.text = category.name
        let imageName = "categoryId\(category.id)"
        imageView.image = UIImage(named: imageName)
    }
}
