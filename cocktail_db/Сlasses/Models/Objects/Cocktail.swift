//
//  Cocktail.swift
//  cocktail_db
//
//  Created by Andrii Bryzhnychenko on 10.12.2019.
//  Copyright © 2019 ltst. All rights reserved.
//

import UIKit

struct Cocktail: Codable {
    private let strDrink: String
    private let strDrinkThumb: String
    private let idDrink: String
    
    var drinkName: String {
        return strDrink
    }
    
    var thumbnailURL: URL? {
        return URL(string: strDrinkThumb)?.appendingPathComponent("preview")
    }
    
    enum CodingKeys: String, CodingKey {
        case strDrink, strDrinkThumb, idDrink
    }
}
