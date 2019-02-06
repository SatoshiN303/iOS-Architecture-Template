//
//  File.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2018年 'OrganizationName'. All rights reserved.
//

import Foundation

extension Bundle {
    func readStringObject(_ key: String) -> String {
        return (object(forInfoDictionaryKey: key) as? String) ?? ""
    }
}
