//
//  NSPredicateExtension.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2018 'OrganizationName'. All rights reserved.
//

import Foundation

/*
 * NSPredicate 平文で条件書かないための拡張
 *
 * [sample]
 *  let predicate = NSPredicate("name", equal: "Ben")
 *
 */

extension NSPredicate {
    
    // MARK: - Public
    
    // 条件が true になる NSPredicate を返す
    static var empty: NSPredicate {
        return NSPredicate(value: true)
    }
    
    convenience init(_ property: String, equal value: AnyObject) {
        self.init(expression: property, "==", value)
        
    }
    
    convenience init(_ property: String, notEqual value: AnyObject) {
        self.init(expression: property, "!=", value)
    }
    
    convenience init(_ property: String, equalOrGreaterThan value: AnyObject) {
        self.init(expression: property, ">=", value)
    }
    
    convenience init(_ property: String, equalOrLessThan value: AnyObject) {
        self.init(expression: property, "<=", value)
    }
    
    convenience init(_ property: String, greaterThan value: AnyObject) {
        self.init(expression: property, ">", value)
    }
    
    convenience init(_ property: String, lessThan value: AnyObject) {
        self.init(expression: property, "<", value)
    }
    
    /// IN句
    convenience init(_ property: String, valuesIn values: [AnyObject]) {
        self.init(format: "\(property) IN %@", argumentArray: [values])
    }
    
    /// Between句
    convenience init(_ property: String, between min: AnyObject, to max: AnyObject) {
        self.init(format: "\(property) BETWEEN {%@, %@}", argumentArray: [min, max])
    }
    
    /// 日付のFromTo
    convenience init(_ property: String, fromDate: NSDate?, toDate: NSDate?) {
        var format = "", args = [AnyObject]()
        
        if let from = fromDate {
            format += "\(property) >= %@"
            args.append(from)
        }
        
        if let to = toDate {
            if !format.isEmpty {
                format += " AND "
            }
            format += "\(property) <= %@"
            args.append(to)
        }
        
        if !args.isEmpty {
            self.init(format: format, argumentArray: args)
        } else {
            self.init(value: true)
        }
    }
    
    // And条件結合
    func and(predicate: NSPredicate) -> NSPredicate {
        return compound(predicates: [predicate], type: .and)
    }
    
    // or条件結合
    func or(predicate: NSPredicate) -> NSPredicate {
        return compound(predicates: [predicate], type: .or)
    }
    
    // not条件結合
    func not(predicate: NSPredicate) -> NSPredicate {
        return compound(predicates: [predicate], type: .not)
    }
    
    // MARK: - Private
    
    // 条件結合検索
    private func compound(predicates: [NSPredicate], type: NSCompoundPredicate.LogicalType = .and) -> NSPredicate {
        var p = predicates; p.insert(self, at: 0)
        switch type {
        case .and:
            return NSCompoundPredicate(andPredicateWithSubpredicates: p)
        case .or:
            return NSCompoundPredicate(orPredicateWithSubpredicates: p)
        case .not:
            return NSCompoundPredicate(notPredicateWithSubpredicate: self.compound(predicates: p))
        }
    }
    
    private convenience init(expression property: String, _ operation: String, _ value: AnyObject) {
        self.init(format: "\(property) \(operation) %@", argumentArray: [value])
    }
}
