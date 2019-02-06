//
//  RealmHelper.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2018年 'OrganizationName'. All rights reserved.
//

//import Foundation
//import RealmSwift
//
//public class RealmHelper {
//
//    public class func find<T: Object>(_ type: T.Type, predicate: NSPredicate, realm: Realm? = nil) -> Results<T>? {
//        let realm = (realm != nil) ? realm : RealmProvider.realm()
//        return realm?.objects(type).filter(predicate)
//    }
//
//    public class func findFirst<T: Object>(_ type: T.Type, _ realm: Realm? = nil) -> T? {
//        return findAll(type, realm)?.first
//    }
//
//    public class func findLast<T: Object>(_ type: T.Type, _ realm: Realm? = nil) -> T? {
//        return findAll(type, realm)?.last
//    }
//
//    public class func findAll<T: Object>(_ type: T.Type, _ realm: Realm? = nil) -> Results<T>? {
//        let realm = (realm != nil) ? realm : RealmProvider.realm()
//        return realm?.objects(type)
//    }
//
//    public class func deleteAll<T: Object>(_ type: T.Type, _ realm: Realm? = nil) throws {
//        let realm = (realm != nil) ? realm : RealmProvider.realm()
//        guard let allObjects = findAll(type, realm) else {
//            return
//        }
//        try realm?.write {
//            realm?.delete(allObjects)
//        }
//    }
//
//    public class func dropDB() throws {
//       let realm = RealmProvider.realm()
//        try realm?.write {
//            realm?.deleteAll()
//        }
//    }
//
//}
