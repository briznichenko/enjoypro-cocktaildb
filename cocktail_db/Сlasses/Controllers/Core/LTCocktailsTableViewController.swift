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
        static let coktailCellFontSize: CGFloat = 16.0
    }
    
    // MARK: - Properties
    
    private var filters: [Any] = []
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.showProgressHud()
        navigationController?.hideProgressHud(afterDelay: 5)
        
        setupRefreshControl()
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
        navigationItem.rightBarButtonItem?.image = filters.isEmpty ? R.image.ic_filter_off() : R.image.ic_filter_on()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.cocktailCell, for: indexPath)

        cell?.imageView?.image = R.image.img_cocktailCellPlaceholder()
        cell?.textLabel?.attributedText = NSAttributedString(string: "Mock", attributes: [.font: R.font.robotoMedium(size: Constants.coktailCellFontSize) ?? .systemFont(ofSize: Constants.coktailCellFontSize)])

        return cell ?? UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // TODO: - Mock
        return "Mock"
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Actions
    
    @objc private func refresh(sender: AnyObject) {
        tableView.refreshControl?.endRefreshing()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: - Mock
        if let test = R.segue.ltCocktailsTableViewController.toFilterViewController(segue: segue) {
            test.destination.filteringDelegate = self
            navigationController?.hideProgressHud()
        }
    }
}

extension LTCocktailsTableViewController: LTFilteringDelegate {
    func didFinishSelecting(filters: [Any]) {
        self.filters = filters
        navigationController?.popToViewController(self, animated: true)
    }
}
