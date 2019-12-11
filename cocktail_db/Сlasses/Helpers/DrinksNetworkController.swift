//
//  DrinksNetworkController.swift
//  cocktail_db
//
//  Created by Andrii Bryzhnychenko on 11.12.2019.
//  Copyright © 2019 ltst. All rights reserved.
//

import UIKit
import SwifterSwift

protocol DrinksNetworkControllerDelegate: class {
    func didLoadCategory(_ category: Category)
}

class DrinksNetworkController: NSObject {
    private var intermediateCategories: [Category] = []
    private var networkManager = DrinksNetworkManager()
    weak var delegate: DrinksNetworkControllerDelegate!
    
    init(delegate: DrinksNetworkControllerDelegate) {
        self.delegate = delegate
    }
    
    func start(_ completion: ((Error?) -> ())? = nil) {
        networkManager.getCategories { [weak self] (categories, error) in
            guard let categories = categories else {
                completion?(error)
                return
            }
            self?.intermediateCategories = categories
            self?.loadNext() { error in
                completion?(error)
            }
        }
    }
    
    func loadNext(_ completion: ((Error?) -> ())? = nil) {
        guard let category = intermediateCategories.first else { return }
        networkManager.getCocktails(for: category) { [weak self] (cocktails, error) in
            guard let cocktails = cocktails else {
                completion?(error)
                return
            }
            // MARK: - TODO
            let category = Category(strCategory: category.strCategory, cocktails: cocktails)
            self?.delegate.didLoadCategory(category)
            completion?(error)
        }
    }

}
