//
//  DrinksNetworkController.swift
//  cocktail_db
//
//  Created by Andrii Bryzhnychenko on 11.12.2019.
//  Copyright © 2019 ltst. All rights reserved.
//

import UIKit
import SwifterSwift

protocol DrinksNetworkControllerLoadDelegate: class {
    func didLoadCategory(_ category: CocktailCategory, withCocktails cocktails: [Cocktail])
    func didLoadCategories(_ categories: [CocktailCategory])
}

protocol DrinksNetworkControllerUIDelegate: class {
    func didStartLoading(shouldShowHUD: Bool)
    func didFinishLoading(_ error: Error?)
}

class DrinksNetworkController: NSObject {
    private var intermediateCategories: [CocktailCategory] = []
    private var networkManager = DrinksNetworkManager()
    weak var delegate: DrinksNetworkControllerLoadDelegate?
    weak var uiDelegate: DrinksNetworkControllerUIDelegate?
    
    init(delegate: DrinksNetworkControllerLoadDelegate, uiDelegate: DrinksNetworkControllerUIDelegate) {
        self.delegate = delegate
        self.uiDelegate = uiDelegate
    }
    
    func reload() {
        uiDelegate?.didStartLoading(shouldShowHUD: true)
        networkManager.getCategories { [weak self] (categories, error) in
            guard let categories = categories else {
                self?.uiDelegate?.didFinishLoading(error)
                return
            }
            self?.intermediateCategories = categories.sorted(by: { $0.strCategory < $1.strCategory })
            self?.delegate?.didLoadCategories(categories)
            self?.loadNext(at: 0)
        }
    }
    
    func loadNext(at section: Int) {
        guard section < intermediateCategories.count else {
            return
        }
        let category = intermediateCategories[section]
        
        uiDelegate?.didStartLoading(shouldShowHUD: false)
        networkManager.getCocktails(for: category) { [weak self] (cocktails, error) in
            guard let cocktails = cocktails else {
                return
            }
            self?.delegate?.didLoadCategory(category, withCocktails: cocktails)
            self?.uiDelegate?.didFinishLoading(error)
        }
    }

}
