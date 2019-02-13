//
//  SamplePresenter.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2019 OrganizationName. All rights reserved.
//

import Foundation
import UIKit

public class SamplePresenter: SamplePresenterInput {
    
    private var users: [User] = []
    weak var view: SamplePresenterOutPut!
    var usecase: SampleUseCaseInput!
    
    var userCount: Int {
        return users.count
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
    
    func searchGitHubUsers(text: String?) {
        guard let query = text, !query.isEmpty else {
            return
        }
        usecase.fetchUser(query: query)
    }
}

extension SamplePresenter: SampleUseCaseOutput {
    
    func successFetch(_ users: [User]) {
        self.users = users
        view.update(users)
    }
    
    func failureFetch(_ error: Error) {
        // Error Handling
    }
    
}
