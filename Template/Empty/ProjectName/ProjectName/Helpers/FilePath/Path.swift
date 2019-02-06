//
//  Path.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2018 OrganizationName. All rights reserved.
//

import Foundation

class Path {
    
    class func isDir(_ path: NSString) -> Bool {
        var isDirectory: ObjCBool = false
        FileManager.default.fileExists(atPath: path as String, isDirectory: &isDirectory)
        return isDirectory.boolValue ? true : false
    }
    
    lazy var fileManager = FileManager.default
    let pathString: String
    
    public init(_ path: String) {
        self.pathString = path
    }
    
    var attributes: NSDictionary? {
        return self.loadAttributes()
    }
    
    var asString: String {
        return pathString
    }
    
    var asURL: URL? {
        return URL(fileURLWithPath: pathString)
    }
    
    var exists: Bool {
        return fileManager.fileExists(atPath: pathString)
    }
    
    var isDir: Bool {
        return Path.isDir(pathString as NSString)
    }
    
    var basename: NSString {
        return ( pathString as NSString ).lastPathComponent as NSString
    }
    
    var parent: Path {
        return Path( (pathString as NSString ).deletingLastPathComponent )
    }
    
    func toString() -> String {
        return pathString
    }
    
    @discardableResult
    func remove() -> PathResult<Path, NSError> {
        assert(self.exists, "To remove file, file MUST be exists")
        do {
            try fileManager.removeItem(atPath: pathString)
            return PathResult(success: self)
        } catch let error as NSError {
            return PathResult(failure: error)
        }
    }
    
    @discardableResult
    func copyTo(_ toPath: Path) -> PathResult<Path, NSError> {
        assert(self.exists, "To copy file, file MUST be exists")
        do {
            try fileManager.copyItem(atPath: pathString,
                                     toPath: toPath.toString())
            return PathResult(success: self)
        } catch let error as NSError {
            return PathResult(failure: error)
        }
    }
    
    @discardableResult
    func moveTo(_ toPath: Path) -> PathResult<Path, NSError> {
        assert(self.exists, "To move file, file MUST be exists")
        do {
            try fileManager.moveItem(atPath: pathString,
                                     toPath: toPath.toString())
            return PathResult(success: self)
        } catch let error as NSError {
            return PathResult(failure: error)
        }
    }
    
    fileprivate func loadAttributes() -> NSDictionary? {
        assert(self.exists, "File must be exists to load file.< \(pathString) >")
        do {
            let result: [FileAttributeKey: Any]? = try self.fileManager.attributesOfItem(atPath: pathString)
            return result as NSDictionary?
        } catch let error as NSError {
            debugPrint("Error< \(error.localizedDescription) >")
            return nil
        }
    }
    
    static func bundlePath(path: String, type: String) -> String? {
        return Bundle.main.path(forResource: path, ofType: type)
    }
    
}

extension Path: CustomStringConvertible {
    var description: String {
        return "\(NSStringFromClass(type(of: self)))<path:\(pathString)>"
    }
}
