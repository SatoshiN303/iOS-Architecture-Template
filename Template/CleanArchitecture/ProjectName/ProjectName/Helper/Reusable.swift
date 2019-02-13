//
//  Reusable.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2019 OrganizationName. All rights reserved.
//

import Foundation
import UIKit

protocol Reusable: class {
}

extension Reusable where Self: UIView {
    static var reuseID: String {
        return String(describing: self)
    }
}
