//
//  ClassifiedADCell.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 21/09/2022.
//

import UIKit

class ClassifiedADCell: UICollectionViewCell {
    static let identifier = String(describing: ClassifiedADCell.self)
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        backgroundColor = .systemBlue
        
        addSubview(label)
        label.setConstraints(top: topAnchor,
                             leading: leadingAnchor,
                             trailing: trailingAnchor,
                             bottom: nil)
    }
    
    func configure(classifiedAD: ClassifiedAD) {
        label.text = classifiedAD.title
    }
}
