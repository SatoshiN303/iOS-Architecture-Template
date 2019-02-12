//
//  SampleViewController.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2019 OrganizationName. All rights reserved.
//

import Foundation
import UIKit

class SampleViewController: UIViewController {

    var presenter: SamplePresenterInput!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    func inject(presenter: SamplePresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = UserTableViewCell.rowHeight
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension SampleViewController: SamplePresenterOutPut {
    func updateUsers(_ users: [User]) {
        self.tableView.reloadData()
    }
}

extension SampleViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchGitHubUser(text: searchBar.text)
    }
}

extension SampleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.userCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter.userCell(tableView, cellForRowAt: indexPath)
    }
}

extension SampleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let user = presenter.user(forRow: indexPath.row) else {
//            return
//        }
//         TODO: Create ViewController and change screen transition
    }
}
