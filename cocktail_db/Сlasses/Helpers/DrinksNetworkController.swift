//
//  DrinksNetworkController.swift
//  cocktail_db
//
//  Created by Andrii Bryzhnychenko on 11.12.2019.
//  Copyright © 2019 ltst. All rights reserved.
//

import UIKit
import SwifterSwift

protocol DrinksNetworkControllerDelegate {
    func didLoadCategory() -> Category
}

class DrinksNetworkController: NSObject {
    private var intermediateCategories: [Category] = []
    private var loadedCategories: [Category] = []
    private var networkManager = DrinksNetworkManager()
    
    func start(completion: @escaping (Error?) -> ()) {
        networkManager.getCategories { [weak self] (categories, error) in
            if let categories = categories {
                self?.intermediateCategories = categories
                self?.loadNext()
            }
        }
    }
    
    func loadNext() {
//        let category = intermediateCategories.first(where: { loadedCategories.cont })
    }

}
