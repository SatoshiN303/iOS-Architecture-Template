//
//  OptionalDecoder.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2019 OrganizationName. All rights reserved.
//

import Foundation

protocol OptionalDecoder {
    var optionalDecodingKey: JSONDecoder.KeyDecodingStrategy? { get }
}

extension OptionalDecoder {
    var optionalDecodingKey: JSONDecoder.KeyDecodingStrategy? {
        return .convertFromSnakeCase
    }
}
