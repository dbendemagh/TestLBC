//
//  UrgentView.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 23/09/2022.
//

import UIKit

class UrgentView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        backgroundColor = .white
        layer.borderWidth = 2
        layer.borderColor = UIColor.orange.cgColor
        layer.cornerRadius = 10
        
        let textLabel = UILabel()
        textLabel.font = UIFont(name: Constants.boldFontName, size: 12)
        textLabel.text = "URGENT"
        textLabel.textColor = .orange
        addSubview(textLabel)
        textLabel.setConstraintCenter(x: centerXAnchor, y: centerYAnchor)
        
        setConstraintSize(size: CGSize(width: 80, height: 20))
    }
}
