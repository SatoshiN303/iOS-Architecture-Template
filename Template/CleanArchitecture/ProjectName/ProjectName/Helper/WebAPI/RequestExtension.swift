//
//  GithubRequest.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2019 OrganizationName. All rights reserved.
//

import APIKit

extension Request where Response: Codable {
    
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
        
    var queryParameters: [String: Any]? {
        return nil
    }
    
    var dataParser: DataParser {
        return DecodableDataParser() as DataParser
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        
        return try JSONDecoder().decode(Response.self, from: data)
    }
}
