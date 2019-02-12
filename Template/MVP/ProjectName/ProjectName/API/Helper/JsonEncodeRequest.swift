//
//  JsonEncodeRequest.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2019 OrganizationName. All rights reserved.
//
import APIKit

protocol JSONEncodeRequest: Request {
}

extension JSONEncodeRequest {
    var headerFields: [String: String] {
        return ["Accept": "application/json"]
    }
}
