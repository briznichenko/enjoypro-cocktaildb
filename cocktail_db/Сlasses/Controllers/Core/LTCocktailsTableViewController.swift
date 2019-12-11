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
    
    var modelController: DrinksModelController!
    private var networkManager: DrinksNetworkManager = DrinksNetworkManager()
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        getCategories()
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
        guard let isSelected = try? modelController.isCategorySelectedAt(section: section), isSelected == true else { return 0}
        return modelController.numberOfCocktailsFor(section: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.cocktailCell, for: indexPath)!

        do {
            let cocktail = try modelController.cocktailAt(indexPath: indexPath)
            cell.setup(cocktail: cocktail)
        } catch {
            print(error.localizedDescription)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let title = try? modelController.categoryAt(section: section).strCategory,
            let isSelected = try? modelController.isCategorySelectedAt(section: section) else { return nil }
        return isSelected == true ? title : nil
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
    private func getCategories() {
        navigationController?.showProgressHud()
        networkManager.getCategories { [weak self] (categories, error) in
            let group = DispatchGroup()
            for i in 0..<(categories ?? []).count{
                guard let categories = categories else { continue }
                group.enter()
                self?.networkManager.getCocktails(for: categories[i]) { (cocktails, error) in
                    self?.modelController.addCategory(categories[i], with: cocktails ?? [])
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

// MARK: - Model Controller

extension LTCocktailsTableViewController: DrinksModelControllerDelegate {
    func didChangeCategoryAt(section: Int) {
        navigationItem.rightBarButtonItem?.image = modelController.numberOfFilteredCategories() > 0 ? R.image.ic_filter_on() : R.image.ic_filter_off()
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
