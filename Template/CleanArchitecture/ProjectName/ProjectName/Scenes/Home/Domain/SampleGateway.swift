//
//  SampleGateway.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2019 OrganizationName. All rights reserved.
//

import APIKit

class SampleGateway: SampleGatewayProtocol {
    
    func executeGitHubSearchUser(request: SearchUserRequest, completion: @escaping (AppResult<[User]>) -> Void) {
        
        Session.send(request, callbackQueue: nil) { result in
            switch result {
            case .success(let response):
                completion(.success(response.items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
