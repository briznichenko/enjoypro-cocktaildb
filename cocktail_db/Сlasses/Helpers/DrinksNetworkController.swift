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
    func didLoadCategory(_ category: CocktailCategory, withCocktails cocktails: [Cocktail])
    func didLoadCategories(_ categories: [CocktailCategory])
}

class DrinksNetworkController: NSObject {
    private var intermediateCategories: [CocktailCategory] = []
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
            self?.intermediateCategories = categories.sorted(by: { $0.strCategory < $1.strCategory })
            self?.delegate.didLoadCategories(categories)
            self?.loadNext(at: 0) { error in
                completion?(error)
            }
        }
    }
    
    func loadNext(at section: Int, _ completion: ((Error?) -> ())? = nil) {
        guard section < intermediateCategories.count else {
            completion?(nil)
            return
        }
        let category = intermediateCategories[section]
        
        networkManager.getCocktails(for: category) { [weak self] (cocktails, error) in
            guard let cocktails = cocktails else {
                completion?(error)
                return
            }
            self?.delegate.didLoadCategory(category, withCocktails: cocktails)
            completion?(error)
        }
    }

}
