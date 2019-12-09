//
//  LTCocktailsTableViewController.swift
//  cocktail_db
//
//  Created by Andrii Bryzhnychenko on 09.12.2019.
//  Copyright © 2019 ltst. All rights reserved.
//

import UIKit
import MBProgressHUD
import Rswift

final class LTCocktailsTableViewController: UITableViewController {
    private struct Constants {
        static let cocktailCellReuseIdentifier = "CocktailCell"
    }
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MBProgressHUD.showAdded(to: view, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cocktailCellReuseIdentifier, for: indexPath)

       // cell.imageView?.image = R.image.cocktailCellPlaceholder()

        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // TODO: - Mock
        return "Mock"
    }

    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
