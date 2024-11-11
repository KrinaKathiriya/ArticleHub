//
//  UIViewX.swift
//  reader
//
//  Created by Krina on 11/11/24.
//

import UIKit

extension UIView {
    func addDropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .init(width: 0, height: 2)
        layer.shadowRadius = 3
    }
}


