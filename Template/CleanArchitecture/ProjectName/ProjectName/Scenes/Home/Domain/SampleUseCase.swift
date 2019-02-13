//
//  SampleUseCase.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2019 OrganizationName. All rights reserved.
//

import Foundation

class SampleUseCase: SampleUseCaseInput {
    
    weak var presenter: SamplePresenter!
    var gateway: SampleGatewayProtocol!
    
    func fetchUser(query: String) {
        let request = SearchUserRequest(query: query,
                                        sort: nil,
                                        order: nil,
                                        page: nil,
                                        perPage: nil)
        weak var weakSelf = self
        
        gateway.executeGitHubSearchUser(request: request) { (result) in
            guard let wself = weakSelf else { return }
            result
                .ifSuccess { users in
                    DispatchQueue.main.async {
                        //TODO: Translate
                        wself.presenter.successFetch(users)
                    }
                }.ifError { error in
                    DispatchQueue.main.async {
                        wself.presenter.failureFetch(error)
                    }
                }
        }
    }
    
}
