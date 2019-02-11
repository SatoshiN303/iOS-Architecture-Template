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
}
