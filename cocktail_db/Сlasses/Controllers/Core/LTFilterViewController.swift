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
    
    weak var filteringDelegate: LTFilteringDelegate?
    var filters: [Category] = []
    var selectedFilters: [Category] = []
    
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
        filteringDelegate?.didFinishSelecting(filters: selectedFilters)
    }
}

// MARK: - Table view data source

extension LTFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.ltFilterTableViewCell, for: indexPath)!
        
        cell.setup(filterName: filters[indexPath.row].strCategory)
        
        return cell
    }
}

// MARK: - Table view delegate

extension LTFilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFilters.append(filters[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedFilters.removeAll(where: { $0.strCategory == filters[indexPath.row].strCategory })
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if selectedFilters.contains(where: { $0.strCategory == filters[indexPath.row].strCategory }) {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .top)
        }
    }
}
