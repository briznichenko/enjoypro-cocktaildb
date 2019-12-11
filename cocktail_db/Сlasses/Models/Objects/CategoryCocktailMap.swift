//
//  CategoryWithCocktails.swift
//  cocktail_db
//
//  Created by Andrii Bryzhnychenko on 11.12.2019.
//  Copyright © 2019 ltst. All rights reserved.
//

import UIKit

class CategoryCocktailMap: Equatable {
    static func == (lhs: CategoryCocktailMap, rhs: CategoryCocktailMap) -> Bool {
        return lhs.category == rhs.category
    }
    
    init (category: CocktailCategory, cocktails: [Cocktail]) {
        self.category = category
        self.cocktails = cocktails
    }
    
    func updateCocktails(_ cocktails: [Cocktail]) {
        self.cocktails = cocktails
    }
    
    let category: CocktailCategory
    private (set) var cocktails: [Cocktail]
    var isFilter: Bool = false
}
