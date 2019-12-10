//
//  MBProgressHUD+CocktailDBStyle.swift
//  cocktail_db
//
//  Created by Andrii Bryzhnychenko on 10.12.2019.
//  Copyright © 2019 ltst. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol CoctailDBProgressHUDStyle {
    func styleProgressHud(margin: CGFloat, cornerRadius: CGFloat)
}

extension MBProgressHUD: CoctailDBProgressHUDStyle {
    func styleProgressHud(margin: CGFloat = 32.0, cornerRadius: CGFloat = 25.0) {
        self.margin = margin
        bezelView.layer.cornerRadius = margin
    }
}
