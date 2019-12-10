//
//  UIButton+Style.swift
//  cocktail_db
//
//  Created by Andrii Bryzhnychenko on 10.12.2019.
//  Copyright © 2019 ltst. All rights reserved.
//

import UIKit

protocol UIViewBorderedStyle {
    func applyBorderedStyle(borderWidth: CGFloat, borderColor: UIColor, cornerRadius: CGFloat)
}

extension UIView: UIViewBorderedStyle {
    func applyBorderedStyle(borderWidth: CGFloat = 1.0, borderColor: UIColor = .black, cornerRadius: CGFloat = 10.0) {
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        layer.cornerRadius = cornerRadius
    }
}
