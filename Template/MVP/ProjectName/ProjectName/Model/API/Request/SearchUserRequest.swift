//
//  SearchUserRequest.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2019 OrganizationName. All rights reserved.
//

/// - : https://developer.github.com/v3/search/#search-users

import Foundation
import APIKit

struct SearchUserRequest: JSONEncodeRequest {

    typealias Response = ItemResponse<User>
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/search/users"
    }
    
    var queryParameters: [String : Any]? {
        var params: [String: String] = ["q": query]
        
        if let sort = sort {
            params["sort"] = sort.rawValue
        }
        if let order = order {
            params["order"] = order.rawValue
        }
        if let page = page {
            params["page"] = "\(page)"
        }
        if let perPage = perPage {
            params["per_page"] = "\(perPage)"
        }
        
        return params
    }
    
    enum Sort: String {
        case followers
        case repositories
        case joined
    }
    
    enum Order: String {
        case asc
        case desc
    }
    
    public let query: String
    public let sort: Sort?
    public let order: Order?
    public let page: Int?
    public let perPage: Int?
    
    public init(query: String, sort: Sort?, order: Order?, page: Int?, perPage: Int?) {
        self.query = query
        self.sort = sort
        self.order = order
        self.page = page
        self.perPage = perPage
    }
}
