//
//  LTFilterTableViewController.swift
//  cocktail_db
//
//  Created by Andrii Bryzhnychenko on 09.12.2019.
//  Copyright © 2019 ltst. All rights reserved.
//

import UIKit
import SwifterSwift

protocol LTFilteringDelegate: class {
    func didFinishSelecting(filters: [Category])
}

final class LTFilterViewController: UIViewController {
    // MARK: - Properties
    
    var modelController: DrinksModelController!
    
    weak var filteringDelegate: LTFilteringDelegate?
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var filterButton: UIButton!
    
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIComponents()
    }
    
    // MARK: - User Interface
    
    private func configureUIComponents() {
        setupTableView()
        setupFilterButton()
    }
    
    private func setupTableView() {
        tableView.register(R.nib.ltFilterTableViewCell)
    }
    
    private func setupFilterButton() {
        filterButton.applyBorderedStyle()
        filterButton.setTitleColor(.gray, for: .highlighted)
    }
        
    // MARK: - IBActions
    
    @IBAction private func didTapApplyFilterButton(_ sender: UIButton) {
        filteringDelegate?.didFinishSelecting(filters: [])
    }
}

// MARK: - Table view data source

extension LTFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelController.numberOfCategories()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.ltFilterTableViewCell, for: indexPath)!
        
        try? cell.setup(category: modelController.categoryAt(section: indexPath.row))
 
        return cell
    }
}

// MARK: - Table view delegate

extension LTFilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        try? modelController.selectCategoryAt(section: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        try? modelController.deselectCategoryAt(section: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let selected = try? modelController.isCategorySelectedAt(section: indexPath.row), selected == true {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
        }
    }
}
