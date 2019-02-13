//
//  DecodableDataParser.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2019 OrganizationName. All rights reserved.
//

import Foundation
import APIKit

// - : seealso https://qiita.com/sgr-ksmt/items/e822a379d41462e05e0d
struct DecodableDataParser: DataParser {
    var contentType: String? {
        return "application/json"
    }
    
    func parse(data: Data) throws -> Any {
        return data
    }
}
