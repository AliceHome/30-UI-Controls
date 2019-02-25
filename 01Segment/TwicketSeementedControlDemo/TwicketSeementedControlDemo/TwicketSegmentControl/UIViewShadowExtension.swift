//
//  UIViewShadowExtension.swift
//  TwicketSeementedControlDemo
//
//  Created by Maple on 2019/2/24.
//  Copyright © 2019 Maple. All rights reserved.
//

import UIKit

extension UIView {
    func addShadow(with color: UIColor) {
        layer.shadowColor = color.cgColor
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    func removeShadow() {
        layer.shadowOpacity = 0
    }
}
