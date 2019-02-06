//
//  ObjectExtension.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2018年 'OrganizationName'. All rights reserved.
//

//import Foundation
//import RealmSwift
//
//public extension Object {
//    
//    public func insert(_ realm: Realm? = nil) throws {
//        let realm = (realm != nil) ? realm : RealmProvider.realm()
//        try realm?.write {
//            realm?.add(self)
//        }
//    }
//    
//    public func update(_ realm: Realm? = nil) throws {
//        let realm = (realm != nil) ? realm : RealmProvider.realm()
//        try realm?.write {
//            realm?.add(self, update: true)
//        }
//    }
//    
//    public func delete(_ realm: Realm? = nil) throws {
//        let realm = (realm != nil) ? realm : RealmProvider.realm()
//        try realm?.write {
//            realm?.delete(self)
//        }
//    }
//    
//    public func edit(_ realm: Realm? = nil, _ hundler: (() -> Void) ) throws {
//        let realm = (realm != nil) ? realm : RealmProvider.realm()
//        try realm?.write(hundler)
//    }
//}
