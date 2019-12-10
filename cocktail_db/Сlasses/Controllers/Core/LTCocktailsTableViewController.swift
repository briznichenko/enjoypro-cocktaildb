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
    }
    
    // MARK: - Properties
    
    private var allCategories: [Category] = []
    private var filteredCategories: [Category] = []
    private var categories: [Category] {
        return filteredCategories.isEmpty ? allCategories : filteredCategories
    }
    private var networkManager: DrinksNetworkManager = DrinksNetworkManager()
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        getCategories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNavigationItem()
    }
    
    // MARK: User Interface
    
    private func setupRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
    }
    
    private func updateNavigationItem() {
        navigationItem.rightBarButtonItem?.image = filteredCategories.isEmpty ? R.image.ic_filter_off() : R.image.ic_filter_on()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories[section].cocktails.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.cocktailCell, for: indexPath)!

        cell.setup(cocktail: categories[indexPath.section].cocktails[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].strCategory
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Actions
    
    @objc private func refresh(sender: AnyObject) {
        getCategories()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueInfo = R.segue.ltCocktailsTableViewController.toFilterViewController(segue: segue) {
            segueInfo.destination.filters = allCategories
            segueInfo.destination.selectedFilters = filteredCategories
            segueInfo.destination.filteringDelegate = self
            navigationController?.hideProgressHud()
        }
    }
}

extension LTCocktailsTableViewController: LTFilteringDelegate {
    func didFinishSelecting(filters: [Category]) {
        filteredCategories = filters
        navigationController?.popToViewController(self, animated: true)
        tableView.reloadData()
    }
}

// MARK: - Networking

extension LTCocktailsTableViewController {
    private func getCategories() {
        navigationController?.showProgressHud()
        networkManager.getCategories { [weak self] (result, error) in
            
            let count = (result?.count ?? 1) - 1
            let group = DispatchGroup()
            self?.allCategories = result ?? []
            
            for i in 0...count{
                group.enter()
                self?.networkManager.getCocktails(for: result![i]) { (cocktails, error) in
                    self?.allCategories[i].cocktails = cocktails ?? []
                    group.leave()
                }
            }
            
            group.notify(queue: DispatchQueue.main) {
               self?.navigationController?.hideProgressHud()
                self?.tableView.refreshControl?.endRefreshing()
                self?.tableView.reloadData()
            }
            
        }
    }
}

class CustomImagedTableViewCell: UITableViewCell {
    @IBOutlet private var thumbnailImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!

    func setup(cocktail: Cocktail) {
        thumbnailImageView.sd_setImage(with: cocktail.thumbnailURL, placeholderImage: R.image.img_cocktailCellPlaceholder())
        nameLabel.attributedText = NSAttributedString(string: cocktail.drinkName)
    }
}
