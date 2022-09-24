//
//  HeaderView.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 22/09/2022.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    static let identifier = String(describing: SectionHeaderView.self)
    
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        addSubview(nameLabel)
        nameLabel.setConstraints(top: topAnchor,
                                 leading: leadingAnchor,
                                 trailing: trailingAnchor,
                                 bottom: nil)
    }
    
    func configure(section: Int) {
        nameLabel.text = section == 0 ? "Catégories" : "Annonces"
    }
}
