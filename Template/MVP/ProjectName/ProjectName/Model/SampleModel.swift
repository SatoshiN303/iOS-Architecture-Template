//
//  SampleModel.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2019 OrganizationName. All rights reserved.
//
import APIKit
import Result

protocol SampleModelInput {
    func fetchUser(query: String,
                   completion: @escaping (AppResult<[User]>) -> Void)
}

protocol SampleModelOutput {
}

public struct SampleModel: SampleModelInput {
    
    func fetchUser(query: String,
                   completion: @escaping (AppResult<[User]>) -> Void) {

        let request = SearchUserRequest(query: query,
                                        sort: nil,
                                        order: nil,
                                        page: nil,
                                        perPage: nil)
        
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
