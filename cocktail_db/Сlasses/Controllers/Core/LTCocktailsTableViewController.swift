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
import SDWebImage

final class LTCocktailsTableViewController: UITableViewController {
    private struct Constants {
        static let coktailCellFontSize: CGFloat = 16.0
        static let paginationLoadingConstant: CGFloat = 500
    }
    
    // MARK: - Properties
    
    var modelController: DrinksModelController!
    var networkController: DrinksNetworkController!
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        loadDrinks()
    }
    
    // MARK: User Interface
    
    private func setupRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return modelController.numberOfCategories()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if modelController.isFiltering {
            return  modelController.isCategorySelectedAt(section: section) ? modelController.numberOfCocktailsFor(section: section) : 0
        }
        return modelController.numberOfCocktailsFor(section: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.cocktailCell, for: indexPath)!

        if let cocktail = modelController.cocktailAt(indexPath: indexPath) {
            cell.setup(cocktail: cocktail)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = modelController.categoryAt(section: section)?.strCategory
        if modelController.isFiltering {
            return modelController.isCategorySelectedAt(section: section) ? title : nil
        }
        return title
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if modelController.numberOfCocktailsFor(section: section) == 0 {
            networkController.loadNext(at: section)
            return
        }
        let nextSection = section + 1
        guard nextSection < modelController.numberOfCategories(), modelController.numberOfCocktailsFor(section: nextSection) == 0 else { return }
        networkController.loadNext(at: nextSection)
    }
    
    // MARK: - Actions
    
    @objc private func refresh(sender: AnyObject) {
        loadDrinks()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueInfo = R.segue.ltCocktailsTableViewController.toFilterViewController(segue: segue) {
            segueInfo.destination.modelController = modelController
            segueInfo.destination.filteringDelegate = self
            navigationController?.hideProgressHud()
        }
    }
}

extension LTCocktailsTableViewController: LTFilteringDelegate {
    func didFinishSelecting(filters: [Category]) {
        navigationController?.popToViewController(self, animated: true)
        tableView.reloadData()
    }
}

// MARK: - Networking

extension LTCocktailsTableViewController {
    private func loadDrinks() {
        networkController.reload()
    }
}

extension LTCocktailsTableViewController: DrinksNetworkControllerUIDelegate {
    func didStartLoading(shouldShowHUD: Bool) {
        if shouldShowHUD {
            navigationController?.showProgressHud()
        }
        tableView.refreshControl?.beginRefreshing()
    }
    
    func didFinishLoading(_ error: Error?) {
        navigationController?.hideProgressHud()
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
}

// MARK: - Model Controller

extension LTCocktailsTableViewController: DrinksModelControllerDelegate {
    func didChangeCategoryAt(section: Int) {
        navigationItem.rightBarButtonItem?.image = modelController.isFiltering ? R.image.ic_filter_on() : R.image.ic_filter_off()
    }
}


/* Using custom imaged cell because default UITableViewCell imageView has resizing issues */
class CustomImagedTableViewCell: UITableViewCell {
    @IBOutlet private var thumbnailImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!

    func setup(cocktail: Cocktail) {
        thumbnailImageView.sd_setImage(with: cocktail.thumbnailURL, placeholderImage: R.image.img_cocktailCellPlaceholder())
        nameLabel.attributedText = NSAttributedString(string: cocktail.drinkName)
    }
}
