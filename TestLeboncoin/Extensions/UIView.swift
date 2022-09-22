//
//  UIView.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 21/09/2022.
//

import UIKit

extension UIView {
    func setConstraints(top: NSLayoutYAxisAnchor?,
                        leading: NSLayoutXAxisAnchor?,
                        trailing: NSLayoutXAxisAnchor?,
                        bottom: NSLayoutYAxisAnchor?,
                        padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
    }
    
    func setConstraintSize(size: CGSize) {
        if size.width > 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height > 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func setConstraintCenter(x: NSLayoutXAxisAnchor?, y: NSLayoutYAxisAnchor?) {
        if let x = x {
            centerXAnchor.constraint(equalTo: x).isActive = true
        }
        
        if let y = y {
            centerYAnchor.constraint(equalTo: y).isActive = true
            
        }
    }
    
    func setConstraintHeight(dimension: NSLayoutDimension) {
        heightAnchor.constraint(equalTo: dimension).isActive = true
    }
    
    func setConstraintCenterY(view: UIView) {
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

