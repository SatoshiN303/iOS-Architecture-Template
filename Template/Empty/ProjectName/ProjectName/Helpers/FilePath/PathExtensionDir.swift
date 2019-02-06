//
//  PathExtensionDir.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2018 OrganizationName. All rights reserved.
//

import Foundation

// Instance Factories for accessing to readable iOS dirs.
#if os(iOS)
    extension Path {
        
        class var homeDir: Path {
            let pathString = NSHomeDirectory()
            return Path( pathString )
        }
        
        class var temporaryDir: Path {
            let pathString = NSTemporaryDirectory()
            return Path( pathString )
        }
        
        class var documentsDir: Path {
            return Path.userDomainOf(.documentDirectory)
        }
        
        class var cacheDir: Path {
            return Path.userDomainOf(.cachesDirectory)
        }
        
        fileprivate class func userDomainOf(_ pathEnum: FileManager.SearchPathDirectory) -> Path {
            let pathString = NSSearchPathForDirectoriesInDomains(pathEnum, .userDomainMask, true)[0]
            return Path( pathString )
        }
        
    }
#endif

// Add Dir Behavior to Path by extension
extension Path: Sequence {
    
    subscript(filename: String) -> Path {
        get { return self.content(filename as NSString) }
    }
    
    var children: [Path]? {
        assert(self.isDir, "To get children, path must be dir< \(pathString) >")
        assert(self.exists, "Dir must be exists to get children.< \(pathString) >")
        do {
            let contents = try self.fileManager.contentsOfDirectory(atPath: pathString ) as [AnyObject]
            
            var tmpContents = [String]()
            for content in contents {
                if let c = content as? String {
                    tmpContents.append(c)
                }
            }
            return tmpContents.map({ [unowned self] content in
                return self.content(content as NSString)
            })
            
        } catch let error as NSError {
            debugPrint("Error< \(error.localizedDescription) >")
            return nil
        }
    }
    
    var contents: [Path]? {
        return self.children
    }
    
    func content(_ pathString: NSString) -> Path {
        return Path(
            URL(fileURLWithPath: self.pathString)
                .appendingPathComponent( pathString as String )
                .path
        )
    }
    
    func child(_ path: NSString) -> Path {
        return self.content(path)
    }
    
    @discardableResult
    func mkdir() -> PathResult<Path, NSError> {
        do {
            try fileManager.createDirectory(atPath: pathString,
                                            withIntermediateDirectories: true,
                                            attributes: nil)
            return PathResult(success: self)
        } catch let error as NSError {
            return PathResult(failure: error)
        }
    }
    
    func makeIterator() -> AnyIterator<Path> {
        assert(self.isDir, "To get iterator, path must be dir< \(pathString) >")
        let iterator = fileManager.enumerator(atPath: pathString)
        return AnyIterator {
            if let optionalContent = iterator?.nextObject() as? String?,
               let content = optionalContent {
                return self.content(content as NSString)
            } else {
                return .none
            }
        }
    }
    
}
