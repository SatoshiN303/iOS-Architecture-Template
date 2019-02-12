//
//  SamplePresenter.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2019 OrganizationName. All rights reserved.
//

import Foundation
import UIKit

protocol SamplePresenterInput {
    var userCount: Int { get }
    func userCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func user(forRow row: Int) -> User?
    func searchGitHubUser(text: String?)

}

protocol SamplePresenterOutPut: AnyObject {
    func updateUsers(_ users: [User])
}

public class SamplePresenter: SamplePresenterInput {
    private (set) var users: [User] = []
    private weak var view: SamplePresenterOutPut!
    private var model: SampleModelInput!
    
    var userCount: Int {
        return users.count
    }
    
    init(view: SamplePresenterOutPut, model: SampleModelInput) {
        self.view = view
        self.model = model
    }
    
    func userCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseID, for: indexPath) as? UserTableViewCell else {
            fatalError()
        }
        
        if indexPath.row < users.count {
            let user = users[indexPath.row]
            cell.configure(with: user)
        }
        
        return cell
    }
    
    func user(forRow row: Int) -> User? {
        guard row < users.count else { return nil }
        return users[row]
    }
    
    func searchGitHubUser(text: String?) {
        guard let query = text, !query.isEmpty else {
            return
        }
        weak var weakSelf = self
        model.fetchUser(query: query) { result in
            guard let wself = weakSelf else { return }
            result
                .ifSuccess { users in
                    DispatchQueue.main.async {
                        wself.users = users
                        wself.view.updateUsers(users)
                    }
                }.ifError { error in
                    // Error Handling
                }
        }
    }
}
