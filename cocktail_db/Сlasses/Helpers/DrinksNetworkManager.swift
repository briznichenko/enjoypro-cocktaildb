//
//  NetworkManager.swift
//  cocktail_db
//
//  Created by Andrii Bryzhnychenko on 10.12.2019.
//  Copyright © 2019 ltst. All rights reserved.
//

import UIKit
import Moya

class DrinksNetworkManager: NSObject {
    private struct Constants {
        static let drinksJSONKey = "drinks"
    }
    
    var provider: MoyaProvider<CocktailDB> {
        return cocktailDBProvider
    }
   
    
    func getCategories(completion: @escaping ([Category]?, Error?) -> ()) {
        provider.request(.categories) { (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let categoriesDictionary = try decoder.decode([String: [Category]].self, from: value.data)
                    completion(categoriesDictionary[Constants.drinksJSONKey], nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
    
    func getCocktails(for category: Category, completion: @escaping ([Cocktail]?, Error?) -> ()) {
        provider.request(.cocktails(category.strCategory)) { (response) in
            switch response.result {
            case .failure(let error):
                completion(nil, error)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let categoriesDictionary = try decoder.decode([String: [Cocktail]].self, from: value.data)
                    completion(categoriesDictionary[Constants.drinksJSONKey], nil)
                } catch let error {
                    completion(nil, error)
                }
            }
        }
    }
}
