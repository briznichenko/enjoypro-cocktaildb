//
//  AppDelegate.swift
//  cocktail_db
//
//  Created by Andrii Bryzhnychenko on 09.12.2019.
//  Copyright © 2019 ltst. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if let navigationController = window?.rootViewController as? UINavigationController,
            let controller = navigationController.viewControllers.first as? LTCocktailsTableViewController {
            controller.modelController = DrinksModelController(delegate: controller)
            controller.networkController = DrinksNetworkController(delegate: controller.modelController, uiDelegate: controller)
        }
        
        return true
    }
}

