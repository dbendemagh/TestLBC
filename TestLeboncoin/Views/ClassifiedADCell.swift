//
//  ClassifiedADCell.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 21/09/2022.
//

import UIKit

class ClassifiedADCell: UICollectionViewCell {
    static let identifier = String(describing: ClassifiedADCell.self)
    
    let titleLabel = UILabel()
    let imageView = UIImageView()
    let priceLabel = UILabel()
    let categoryLabel = UILabel()
    let urgentView = UrgentView()
    
    var categoryName: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        //backgroundColor = .systemGray5 // systemBackground
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        addSubview(imageView)
        imageView.setConstraints(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil)
        imageView.setConstraintSize(size: CGSize(width: 0, height: 250))
        
        addSubview(urgentView)
        urgentView.setConstraints(top: imageView.topAnchor,
                                  leading: imageView.leadingAnchor,
                                  trailing: nil,
                                  bottom: nil,
                                  padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0))
        
        titleLabel.font = UIFont(name: Constants.boldFontName, size: 18)
        titleLabel.numberOfLines = 2
        addSubview(titleLabel)
        titleLabel.setConstraints(top: imageView.bottomAnchor,
                             leading: leadingAnchor,
                             trailing: trailingAnchor,
                             bottom: nil)
        
        priceLabel.font = UIFont(name: Constants.boldFontName, size: 15)
        addSubview(priceLabel)
        priceLabel.setConstraints(top: titleLabel.bottomAnchor,
                             leading: leadingAnchor,
                             trailing: trailingAnchor,
                             bottom: nil)
        
        categoryLabel.textColor = .secondaryLabel
        addSubview(categoryLabel)
        categoryLabel.setConstraints(top: priceLabel.bottomAnchor,
                                 leading: leadingAnchor,
                                 trailing: trailingAnchor,
                                 bottom: nil)
        
    }
    
    func configure(classifiedAD: ClassifiedAD) {
        titleLabel.text = classifiedAD.title
        priceLabel.text = "\(classifiedAD.price) €"
        categoryLabel.text = categoryName
        
        urgentView.isHidden = !classifiedAD.isUrgent
    }
    
    func setImage(result: Result<UIImage, LBCError>) {
        switch result {
        case .success(let image):
            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = image
            }
        case .failure(_):
            break
        }
    }
}
