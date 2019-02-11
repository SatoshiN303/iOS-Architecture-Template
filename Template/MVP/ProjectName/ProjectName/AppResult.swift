//
//  AppResult.swift
//  ProjectName
//
//  Created by 佐藤 慎 on 2019/02/11.
//Copyright © 2019年 'XLOrganizationName'. All rights reserved.
//

enum AppResult<T> {
    case success(T)
    case failure(Error)
}
