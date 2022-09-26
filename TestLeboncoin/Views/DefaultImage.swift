//
//  DefaultImage.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 25/09/2022.
//

import UIKit

class DefaultImage: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        backgroundColor = .systemGray5
        layer.cornerRadius = 10
        
        let imageView = UIImageView()
        imageView.image = SFSymbols.questionMark
        imageView.tintColor = .white
        addSubview(imageView)
        imageView.setConstraintSize(size: CGSize(width: 100, height: 100))
        imageView.setConstraintCenter(x: centerXAnchor, y: centerYAnchor)
    }
}
