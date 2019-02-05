#!/usr/bin/swift
//
//  main.swift
//  Bootstrap
//
//  Created on 2019/02/5
//  Copyright © 2018年 shin-sato. All rights reserved.
//


import Foundation

public enum ArchitectureType: String {
    case empty = "Empty"
    case mvc = "Cocoa MVC"
    case mvp = "MVP"
    case mvvm = "MVVM"
    case viper = "VIPER"
    case cleanArc = "CleanArchitecture"
}

public struct ProjectSettings {
    var architecture: ArchitectureType
    var name: String
    var bundleID: String
    var author: String
    var organizationName: String
}

public struct Templates {
    static let projectName = "XLProjectName"
    static let bundleDomain = "XLOrganizationIdentifier"
    static let author = "XLAuthorName"
    static let userName = "XLUserName"
    static let organizationName = "XLOrganizationName"
}

public struct Console {
    
    public static func shell(path: String, args: String...) -> (output: String, exitCode: Int32) {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = args
        task.currentDirectoryPath = path
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        task.waitUntilExit()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String? ?? ""
        return (output, task.terminationStatus)
    }
    
    @discardableResult
    public static func prompt(message: String, defaultValue: String) -> String {
        print("\n> \(message) (or press Enter to use defaultValue is「\(defaultValue)」)")
        let line = readLine()
        return line == nil || line == "" ? defaultValue : line!
    }
    
    @discardableResult
    public static func select(message: String, choices: [String], defaultValue: String) -> String {
        print("\n> \(message) (or press Enter to use defaultValue is「\(defaultValue)」)")
        for (idx, choise) in choices.enumerated() {
            print("\(idx)) \(choise)")
        }
        let line = readLine()
        return line == nil || line == "" ? defaultValue : line!
    }
    
    public static func printInfo<T>(message: T)  {
        print("\n-------------------Info:-------------------------")
        print("\(message)")
        print("--------------------------------------------------\n")
    }
    
    public static func printErrorAndExit<T>(message: T) {
        print("\n-------------------Error:-------------------------")
        print("\(message)")
        print("--------------------------------------------------\n")
        exit(1)
    }
}

public struct Dialogue {
    
    private var settings: ProjectSettings
    
    init(settings: ProjectSettings) {
        self.settings = settings
    }
    
    @discardableResult
    func selectArchitecture() -> ArchitectureType {
        let choise = Console.select(message: "アーキテクチャーを選択してください", choices: ["Empty","MVC","MVP","MVVM","VIPER","CleanArchitecture"], defaultValue: "Empty")
        // TODO:
        return .empty
    }
    
    @discardableResult
    func inputProjectName() -> String {
        return Console.prompt(message: "プロジェクト名を入力してください", defaultValue: settings.name)
    }
    
    @discardableResult
    func settingBundleID() -> String {
        return Console.prompt(message: "BundleIDを入力してください", defaultValue: settings.bundleID)
    }
    
    @discardableResult
    func settingAuthor() -> String {
        return Console.prompt(message: "コード署名に記載されるAuthorを入力してください", defaultValue: settings.author)
    }
    
    @discardableResult
    func settingOrganizationName() -> String {
        return Console.prompt(message: "Organization Name", defaultValue: settings.organizationName)
    }
    
}

// MARK: - Extension

extension NSURL {
    
    var toURL: URL {
        return self as URL
    }
    
    var fileName: String? {
        var fileName: AnyObject?
        do {
            try getResourceValue(&fileName, forKey:  URLResourceKey.nameKey)
        } catch let error as NSError {
            Console.printErrorAndExit(message: error.localizedDescription)
            return nil
        }
        return fileName as? String
    }
    
    var isDirectory: Bool {
        var isDirectory: AnyObject?
        do {
            try getResourceValue(&isDirectory, forKey:  URLResourceKey.isDirectoryKey)
        } catch let error as NSError {
            Console.printErrorAndExit(message: error.localizedDescription)
            return false
        }
        return isDirectory as? Bool ?? false
    }
    
    func renameIfNeeded(_ projectName: String) {
        guard let fileName = fileName, let _ = fileName.range(of: Templates.projectName) else {
            return
        }
        let renamedFileName = fileName.replacingOccurrences(of: Templates.projectName, with: projectName)
        do {
            try FileManager.default.moveItem(at: self as URL, to: NSURL(fileURLWithPath: renamedFileName, relativeTo: deletingLastPathComponent) as URL)
        } catch let error as NSError {
            Console.printErrorAndExit(message: error.localizedDescription)
        }
    }
    
    func updateContent(settings: ProjectSettings) {
        guard let path = path else {
            print("ERROR READING: \(self)")
            return
        }
        guard let content = try? String(contentsOfFile: path, encoding: String.Encoding.utf8) else {
            return
        }
        
        var newContent = content.replacingOccurrences(of: Templates.projectName, with: settings.name)
        newContent = newContent.replacingOccurrences(of: Templates.bundleDomain, with: settings.bundleID)
        newContent = newContent.replacingOccurrences(of: Templates.author, with: settings.author)
        newContent = newContent.replacingOccurrences(of: Templates.organizationName, with: settings.organizationName)
        
        do {
            try newContent.write(to: self as URL, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("ERROR Write Content: \(self)")
        }
    }
}

public class FilePath {
    
    public lazy var fileManager: FileManager = {
        return FileManager.default
    }()
    
    public var runScriptPathURL: NSURL {
        return NSURL(fileURLWithPath: fileManager.currentDirectoryPath, isDirectory: true)
    }
    
    public var currentScriptPathURL: NSURL {
        guard let arg = CommandLine.arguments.first else {
            fatalError()
        }
        guard let path = NSURL(fileURLWithPath: arg, relativeTo: runScriptPathURL.toURL).deletingLastPathComponent?.path else {
            fatalError()
        }
        return NSURL(fileURLWithPath: path, isDirectory: true)
    }
    
    func projectTemplateURL(type: ArchitectureType) -> NSURL {
        return NSURL(fileURLWithPath: type.rawValue, relativeTo: currentScriptPathURL as URL)
    }
    
    func generatedDirectoryURL(settings: ProjectSettings) -> NSURL {
        return NSURL(fileURLWithPath: settings.name, relativeTo: runScriptPathURL.toURL)
    }
    
    func isAlreadyExist(settings: ProjectSettings) -> Bool {
        let generatedURL = generatedDirectoryURL(settings: settings)
        guard let generatedProjectFolderPath = generatedURL.path, !generatedProjectFolderPath.isEmpty  else {
            Console.printErrorAndExit(message: "newProjectFolderPath failure Unwrapped or isEmpty")
            fatalError()
        }
        var isDirectory: ObjCBool = true
        return fileManager.fileExists(atPath: generatedProjectFolderPath, isDirectory: &isDirectory)
    }
}

// MARK: - Start Generation

public class Main {
    private let ignoredFiles = [".DS_Store", "UserInterfaceState.xcuserstate"]
    private let filepath = FilePath()
    private var projectSettings = ProjectSettings(architecture: .empty,
                                                  name: "ProjectName",
                                                  bundleID: "jp.co.companyname",
                                                  author: "Developer",
                                                  organizationName: "Hoge, Inc")
    private lazy var dialogue = Dialogue(settings: projectSettings)
    
    public func start() {
        
        print("\nLet's go over some question to generate your base project code!")
        print(filepath.runScriptPathURL.absoluteString!)
        
        projectSettings.name = dialogue.inputProjectName()
        
        if filepath.isAlreadyExist(settings: projectSettings) {
            Console.printErrorAndExit(message: "folder already exists in \(String(describing: filepath.runScriptPathURL.path)) directory, please delete it and try again")
        }
        
        projectSettings.bundleID = dialogue.settingBundleID()
        projectSettings.author = dialogue.settingAuthor()
        projectSettings.organizationName = dialogue.settingOrganizationName()
        projectSettings.architecture = dialogue.selectArchitecture()
        
        copyTemplateFolder()
        rename()
        carthage()
        cocoapods()
        open()
    }
    
    private func copyTemplateFolder() {
        do {
            let templateURL = filepath.projectTemplateURL(type: projectSettings.architecture).toURL
            let newURL = filepath.generatedDirectoryURL(settings: projectSettings).toURL
            try filepath.fileManager.copyItem(at: templateURL, to: newURL)
        } catch let error as NSError {
            Console.printErrorAndExit(message: error.localizedDescription)
        }
    }
    
    private func rename() {
        let newURL = filepath.generatedDirectoryURL(settings: projectSettings).toURL
        guard let enumerator = filepath.fileManager.enumerator(at: newURL, includingPropertiesForKeys: [.nameKey, .isDirectoryKey], options: [], errorHandler: nil) else {
            Console.printErrorAndExit(message: "failure rename")
            return
        }
        var directories = [NSURL]()
        
        print("\nCreating \(projectSettings.name) ...")
        
        for file in enumerator.allObjects {
            guard let fileURL = file as? NSURL else {
                print("unwrapped failure", file)
                continue
            }
            guard let fileName = fileURL.fileName,  !ignoredFiles.contains(fileName) else {
                continue
            }
            
            if fileURL.isDirectory {
                directories.append(fileURL)
            } else {
                fileURL.updateContent(settings: projectSettings)
                fileURL.renameIfNeeded(projectSettings.name)
            }
        }
        
        for fileURL in directories.reversed() {
            fileURL.renameIfNeeded(projectSettings.name)
        }
    }
    
    private func carthage() {
    }
    
    private func cocoapods() {
    }
    
    private func open() {
    }
    
}

//let fileManager = FileManager.default
//let runScriptPathURL = NSURL(fileURLWithPath: fileManager.currentDirectoryPath, isDirectory: true)
//
//guard let firstARG = CommandLine.arguments.first else {
//    fatalError()
//}
//
//guard let path = NSURL(fileURLWithPath: firstARG, relativeTo: runScriptPathURL as URL).deletingLastPathComponent?.path else {
//    fatalError()
//}
//
//let currentScriptPathURL = NSURL(fileURLWithPath: path, isDirectory: true)
//let iOSProjectTemplateForlderURL = NSURL(fileURLWithPath: "Project-iOS", relativeTo: currentScriptPathURL as URL)
//let ignoredFiles = [".DS_Store", "UserInterfaceState.xcuserstate"]
//
//
//// MARK: - Start project Settings Input
//
//print("\nLet's go over some question to generate your base project code!")
//print(runScriptPathURL.absoluteString!)
//print(path)
//projectSettings.name = Console.prompt(message: "Project name", defaultValue: projectSettings.name)
//
////Check if folder already exists
//let newProjectFolderURL = NSURL(fileURLWithPath: projectSettings.name, relativeTo: runScriptPathURL as URL)
//guard let newProjectFolderPath = newProjectFolderURL.path, !newProjectFolderPath.isEmpty  else {
//    Console.printErrorAndExit(message: "newProjectFolderPath failure Unwrapped or isEmpty")
//    fatalError()
//}
//var isDirectory: ObjCBool = true
//if fileManager.fileExists(atPath: newProjectFolderPath, isDirectory: &isDirectory){
//    Console.printErrorAndExit(message: "\(isDirectory.boolValue ? "folder already" : "file") exists in \(String(describing: runScriptPathURL.path)) directory, please delete it and try again")
//}
//
//projectSettings.bundleDomain = Console.prompt(message: "Bundle domain", defaultValue: projectSettings.bundleDomain)
//projectSettings.author       = Console.prompt(message: "Author", defaultValue: projectSettings.author)
//projectSettings.organizationName = Console.prompt(message: "Organization Name", defaultValue: projectSettings.organizationName)
//
//// MARK: - Copy template folder to a new folder inside run script url called projectName
//
//do {
//    try fileManager.copyItem(at: iOSProjectTemplateForlderURL as URL, to: newProjectFolderURL as URL)
//} catch let error as NSError {
//    Console.printErrorAndExit(message: error.localizedDescription)
//}
//
//// MARK: - Rename files and update content
//
//let enumerator = fileManager.enumerator(at: newProjectFolderURL as URL, includingPropertiesForKeys: [.nameKey, .isDirectoryKey], options: [], errorHandler: nil)!
//var directories = [NSURL]()
//
//print("\nCreating \(projectSettings.name) ...")
//
//for file in enumerator.allObjects {
//    guard let fileURL = file as? NSURL else {
//        print("unwrapped failure", file)
//        continue
//    }
//    guard let fileName = fileURL.fileName,  !ignoredFiles.contains(fileName) else {
//        continue
//    }
//
//    if fileURL.isDirectory {
//        directories.append(fileURL)
//    } else {
//        fileURL.updateContent(settings: projectSettings)
//        fileURL.renameIfNeeded(projectSettings.name)
//    }
//}
//
//for fileURL in directories.reversed() {
//    fileURL.renameIfNeeded(projectSettings.name)
//}
//
//var name = projectSettings.name
//print("newProjectFolderPath = \(newProjectFolderPath)")
//
//print("carthage bootstrap --platform iOS --no-use-binaries --cache-builds")
//print(Console.shell(path: "/\(newProjectFolderPath)/\(name)", args: "carthage", "bootstrap", "--platform", "iOS","--no-use-binaries","--cache-builds").output)
//
//print("pod install --project-directory=\(name) --no-repo-update\n")
//print(Console.shell(path: newProjectFolderPath, args: "pod", "install", "--project-directory=\(name)").output)
//
//
//print("open \(name)/\(name).xcworkspace\n")
//print(Console.shell(path: newProjectFolderPath, args: "open", "\(name)/\(name).xcworkspace").output)
