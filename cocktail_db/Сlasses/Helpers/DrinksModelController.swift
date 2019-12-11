//
//  DrinksModelController.swift
//  cocktail_db
//
//  Created by Andrii Bryzhnychenko on 11.12.2019.
//  Copyright © 2019 ltst. All rights reserved.
//

import UIKit
import SwifterSwift

enum DrinksModelControllerError: Error {
    case indexPathOutOfRange
    
    var localizedDescription: String {
        return "Index out of range!"
    }
}

protocol DrinksModelControllerDelegate {
    func didChangeCategoryAt(section: Int)
}

final class DrinksModelController: NSObject {
    private var categories: [CategoryWithCocktails] = [] {
        didSet {
            categories.removeDuplicates()
            categories.sort { $0.category.strCategory < $1.category.strCategory }
        }
    }
    
    var isFiltered: Bool {
        return categories.filter { $0.isFilter == true }.isEmpty == false
    }
    
    var delegate: DrinksModelControllerDelegate?
    
    init(delegate: DrinksModelControllerDelegate) {
        self.delegate = delegate
    }
    
    func setCategories(_ data: [CategoryWithCocktails]) {
        categories = data
    }
    
    func addCategory(_ category: Category, with cocktails: [Cocktail]) {
        let categoryWithCocktails = CategoryWithCocktails(category: category, cocktails: cocktails)
        categories.append(categoryWithCocktails)
        delegate?.didChangeCategoryAt(section: categories.lastIndex(of: categoryWithCocktails) ?? 0)
        
    }
    
    func numberOfCategories() -> Int {
        return categories.count
    }
    
    func numberOfCocktailsFor(section: Int) -> Int {
        guard section < categories.count else { return 0 }
        return categories[section].cocktails.count
    }
    
    func categoryAt(section: Int) throws -> Category {
        guard section < categories.count else { throw DrinksModelControllerError.indexPathOutOfRange }
        return categories[section].category
    }
    
    func isCategorySelectedAt(section: Int) throws -> Bool? {
        guard section < categories.count else { throw DrinksModelControllerError.indexPathOutOfRange }
        return categories[section].isFilter
    }
    
    func cocktailAt(indexPath: IndexPath) throws -> Cocktail {
        guard indexPath.section < categories.count,
            indexPath.row < categories[indexPath.section].cocktails.count else {
                throw DrinksModelControllerError.indexPathOutOfRange
        }
        return categories[indexPath.section].cocktails[indexPath.row]
    }
    
    func selectCategoryAt(section: Int) throws {
    guard section < categories.count else { throw DrinksModelControllerError.indexPathOutOfRange }
        categories[section].isFilter = true
        delegate?.didChangeCategoryAt(section: section)
    }
    
    func deselectCategoryAt(section: Int) throws {
    guard section < categories.count else { throw DrinksModelControllerError.indexPathOutOfRange }
        categories[section].isFilter = false
        delegate?.didChangeCategoryAt(section: section)
    }
}
