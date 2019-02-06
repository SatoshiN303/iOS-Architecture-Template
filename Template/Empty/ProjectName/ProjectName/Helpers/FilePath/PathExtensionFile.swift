//
//  PathExtensionFile.swift
//  ProjectName
//
//  Created by AuthorName
//  Copyright © 2018 OrganizationName. All rights reserved.
//

import Foundation

// Add File Behavior to Path by extension
extension  Path {
    
    var ext: NSString {
        return URL(fileURLWithPath: pathString).pathExtension as NSString
    }
    
    @discardableResult
    func touch() -> PathResult<Path, NSError> {
        assert(!self.isDir, "Can NOT touch to dir")
        return self.exists
            ? self.updateModificationDate()
            : self.createEmptyFile()
    }
    
    @discardableResult
    func updateModificationDate(_ date: Date = Date() ) -> PathResult<Path, NSError> {
        do {
            try fileManager.setAttributes(
                [FileAttributeKey.modificationDate: date],
                ofItemAtPath: pathString)
            return PathResult(success: self)
        } catch let error as NSError {
            return PathResult(failure: error)
        }
    }
    
    @discardableResult
    fileprivate func createEmptyFile() -> PathResult<Path, NSError> {
        return self.writeString("")
    }
    
    // MARK: - read/write String
    
    func readString() -> String? {
        assert(!self.isDir, "Can NOT read data from  dir")
        var readError: NSError?
        let read: String?
        do {
            read = try String(contentsOfFile: pathString,
                              encoding: String.Encoding.utf8)
        } catch let error as NSError {
            readError = error
            read = nil
        }
        
        if let error = readError {
            print("readError< \(error.localizedDescription) >")
        }
        
        return read
    }
    
    @discardableResult
    func writeString(_ string: String) -> PathResult<Path, NSError> {
        assert(!self.isDir, "Can NOT write data from  dir")
        do {
            try string.write(toFile: pathString,
                             atomically: true,
                             encoding: String.Encoding.utf8)
            return PathResult(success: self)
        } catch let error as NSError {
            return PathResult(failure: error)
        }
    }
    
    // MARK: - read/write NSData
    
    func readData() -> Data? {
        assert(!self.isDir, "Can NOT read data from  dir")
        return (try? Data(contentsOf: URL(fileURLWithPath: pathString)))
    }
    
    @discardableResult
    func writeData(_ data: Data) -> PathResult<Path, NSError> {
        assert(!self.isDir, "Can NOT write data from  dir")
        do {
            try data.write(to: URL(fileURLWithPath: pathString), options: .atomic)
            return PathResult(success: self)
        } catch let error as NSError {
            return PathResult(failure: error)
        }
    }
    
}
