//
//  Category.swift
//  cocktail_db
//
//  Created by Andrii Bryzhnychenko on 10.12.2019.
//  Copyright © 2019 ltst. All rights reserved.
//

import UIKit

struct Category: Codable {
    let strCategory: String
    
    enum CodingKeys: String, CodingKey {
        case strCategory
    }
}
