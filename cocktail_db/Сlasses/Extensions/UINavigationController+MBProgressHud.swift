//
//  UIViewController+MBProgressHud.swift
//  cocktail_db
//
//  Created by Andrii Bryzhnychenko on 09.12.2019.
//  Copyright © 2019 ltst. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UINavigationController {
    func showProgressHud(animated: Bool = true, shouldStyle: Bool = true) {
        MBProgressHUD.showAdded(to: view, animated: animated)
        if shouldStyle == true {
            MBProgressHUD(for: view)?.styleProgressHud()
        }
    }
    
    func hideProgressHud(animated: Bool = true, afterDelay: TimeInterval = 0) {
        MBProgressHUD(for: view)?.hide(animated: animated, afterDelay: afterDelay)
    }
}
