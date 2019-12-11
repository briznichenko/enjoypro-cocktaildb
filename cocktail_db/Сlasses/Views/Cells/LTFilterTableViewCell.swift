//
//  LTFilterTableViewCell.swift
//  cocktail_db
//
//  Created by Andrii Bryzhnychenko on 10.12.2019.
//  Copyright © 2019 ltst. All rights reserved.
//

import UIKit

class LTFilterTableViewCell: UITableViewCell {
    @IBOutlet private var filterNameLabel: UILabel!

    func setup(category: Category) {
        filterNameLabel.text = category.strCategory
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        accessoryType = isSelected ? .checkmark : .none
    }
    
}
