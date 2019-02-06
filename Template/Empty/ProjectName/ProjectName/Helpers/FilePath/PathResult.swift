//
//  PathResult.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2018 OrganizationName. All rights reserved.
//
import Foundation

enum PathResult<S, F> {
    
    case success(S)
    case failure(F)
    
    init(success: S) {
        self = .success(success)
    }
    
    init(failure: F) {
        self = .failure(failure)
    }
    
    var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
        
    }
    
    var isFailure: Bool {
        switch self {
        case .success:
            return false
        case .failure:
            return true
        }
    }
    
    var value: S? {
        switch self {
        case .success(let success):
            return success
        case .failure(_):
            return .none
        }
    }
    
    var error: F? {
        switch self {
        case .success(_):
            return .none
        case .failure(let error):
            return error
        }
    }
    
    func onFailure(_ handler: (F) -> Void ) -> PathResult<S, F> {
        switch self {
        case .success(_):
            return self
        case .failure(let error):
            handler( error )
            return self
        }
    }
    
    func onSuccess(_ handler: (S) -> Void ) -> PathResult<S, F> {
        switch self {
        case .success(let success):
            handler(success)
            return self
        case .failure(_):
            return self
        }
    }
    
}
