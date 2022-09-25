//
//  TitleLabel.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 25/09/2022.
//

import Foundation

import UIKit

class TitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment = .left, fontSize: CGFloat = 20) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont(name: Constants.boldFontName, size: fontSize)
    }
    
    private func configure() {
        font = UIFont(name: Constants.boldFontName, size: 20)
    }
}
