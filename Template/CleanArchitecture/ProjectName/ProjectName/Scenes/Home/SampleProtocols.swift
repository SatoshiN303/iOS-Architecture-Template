//
//  SampleProtocols.swift
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
    func searchGitHubUsers(text: String?)
}

protocol SamplePresenterOutPut: AnyObject {
    func update(_ users: [User])
}

protocol SampleUseCaseInput {
    func fetchUser(query: String)
}

protocol SampleUseCaseOutput {
    func successFetch(_ users: [User])
    func failureFetch(_ error: Error)
}

protocol SampleGatewayProtocol {
    func executeGitHubSearchUser(request: SearchUserRequest, completion: @escaping (AppResult<[User]>) -> Void)
}
