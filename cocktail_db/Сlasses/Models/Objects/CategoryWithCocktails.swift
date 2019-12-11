//
//  CategoryWithCocktails.swift
//  cocktail_db
//
//  Created by Andrii Bryzhnychenko on 11.12.2019.
//  Copyright © 2019 ltst. All rights reserved.
//

import UIKit

struct CategoryWithCocktails: Equatable {
    static func == (lhs: CategoryWithCocktails, rhs: CategoryWithCocktails) -> Bool {
        return lhs.category.strCategory == rhs.category.strCategory
    }
    
    let category: Category
    let cocktails: [Cocktail]
    var isSelected: Bool = true
}
