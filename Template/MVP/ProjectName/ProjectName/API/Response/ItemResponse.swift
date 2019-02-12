//
//  ItemResponse.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2019 OrganizationName. All rights reserved.
//

import Foundation

public struct ItemResponse<Item: Codable>: Codable {
    public var totalCount: Int
    public var incompleteResults: Bool
    public var items: [Item]
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
    
    public init(totalCount: Int, incompleteResults: Bool, items: [Item]) {
        self.totalCount = totalCount
        self.incompleteResults = incompleteResults
        self.items = items
    }
}
