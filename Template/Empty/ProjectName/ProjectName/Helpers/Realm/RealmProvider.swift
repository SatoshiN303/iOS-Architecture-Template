//
//  RealmProvider.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2018 'OrganizationName'. All rights reserved.
//

//import Foundation
//import UIKit
//import RealmSwift
//
//class RealmProvider {
//
//    private static let schemaVersion: UInt64 = 1
//
//    private static var config = Realm.Configuration(schemaVersion: schemaVersion,
//                                                    migrationBlock: { _, oldSchemaVersion in
//                                                        // We haven’t migrated anything yet, so oldSchemaVersion == 0
//                                                        if oldSchemaVersion < 1 {
//                                                            // Nothing to do!
//                                                            // Realm will automatically detect new properties and removed properties
//                                                            // And will update the schema on disk automatically
//                                                        }
//    })
//
//    public class func realm() -> Realm? {
//        if NSClassFromString("XCTest") != nil {
//            return try? Realm(configuration: Realm.Configuration(inMemoryIdentifier: NSUUID().uuidString))
//        } else {
//            return try? Realm(configuration: config)
//        }
//    }
//
//}
