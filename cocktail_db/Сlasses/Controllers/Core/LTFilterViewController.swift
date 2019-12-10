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
    func didFinishSelecting(filters: [Any])
}

final class LTFilterViewController: UIViewController {
    private struct Constants {
        static let rowHeight: CGFloat = 44.0
    }
    
    // MARK: - Properties
    
    weak var filteringDelegate: LTFilteringDelegate?
    private var mockFilters = Array(repeating: "MOCK", count: 10)
    private var selectedFilters: [Any] = []
    
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
        return mockFilters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.ltFilterTableViewCell, for: indexPath)
        
        cell?.setup(filterName: mockFilters[indexPath.row])
        cell?.selectionStyle = .none
        
        return cell ?? UITableViewCell()
    }
}

// MARK: - Table view delegate

extension LTFilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFilters.append(mockFilters[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }
}
