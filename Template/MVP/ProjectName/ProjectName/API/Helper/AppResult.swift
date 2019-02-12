//
//  AppResult.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2019 OrganizationName. All rights reserved.
//

enum AppResult<T> {
    case success(T)
    case failure(Error)
    
    @discardableResult
    func ifSuccess(_ f: (T) -> Void) -> AppResult {
        if case let .success(value) = self {
            f(value)
        }
        return self
    }
    
    @discardableResult
    func ifError(_ f: (Error) -> Void) -> AppResult {
        if case let .failure(error) = self {
            f(error)
        }
        return self
    }
}
