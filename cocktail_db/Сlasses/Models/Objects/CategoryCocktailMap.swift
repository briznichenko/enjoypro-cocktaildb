//
//  CategoryWithCocktails.swift
//  cocktail_db
//
//  Created by Andrii Bryzhnychenko on 11.12.2019.
//  Copyright © 2019 ltst. All rights reserved.
//

import UIKit

struct CategoryCocktailMap: Equatable {
    static func == (lhs: CategoryCocktailMap, rhs: CategoryCocktailMap) -> Bool {
        return lhs.category == rhs.category
    }
    
    let category: CocktailCategory
    let cocktails: [Cocktail]
    var isFilter: Bool = false
}
