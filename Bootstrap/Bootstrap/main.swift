#!/usr/bin/swift
//
//  main.swift
//  Bootstrap
//
//  Created on 2019/02/5
//  Copyright © 2018年 shin-sato. All rights reserved.
//


import Foundation

public enum ArchitectureType: String,  CaseIterable {
    case empty = "Empty"
    case mvc = "CocoaMVC"
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

public struct Template {
    static let projectName = "ProjectName"
    static let bundleDomain = "OrganizationIdentifier"
    static let author = "AuthorName"
    static let organizationName = "OrganizationName"
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
        
        guard let line = readLine(), !line.isEmpty else {
            return defaultValue
        }
        
        let range: CountableRange<Int> = 0..<choices.count
        let isOutRange = range.filter { (idx) -> Bool in return "\(idx)" == line }.count == 0
        
        if isOutRange {
            print("Please enter a number")
            return select(message: message, choices: choices, defaultValue: defaultValue)
        }
        
        return line
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
        let typeNames = ArchitectureType.allCases.map { (type) -> String in type.rawValue }
        let choise = Console.select(message: "Enter the architecture number", choices: typeNames, defaultValue: "0")
        
        guard let choiseNumber = Int(choise) else {
            fatalError()
        }
        
        return ArchitectureType.allCases[choiseNumber]
    }
    
    @discardableResult
    func inputProjectName() -> String {
        return Console.prompt(message: "Enter the project name", defaultValue: settings.name)
    }
    
    @discardableResult
    func settingBundleID() -> String {
        return Console.prompt(message: "Enter the bundle identifier", defaultValue: settings.bundleID)
    }
    
    @discardableResult
    func settingAuthor() -> String {
        return Console.prompt(message: "Enter the Author listed in the code signature", defaultValue: settings.author)
    }
    
    @discardableResult
    func settingOrganizationName() -> String {
        return Console.prompt(message: "Enter the OrganizationName listed in the code signature", defaultValue: settings.organizationName)
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
        guard let fileName = fileName, let _ = fileName.range(of: Template.projectName) else {
            return
        }
        let renamedFileName = fileName.replacingOccurrences(of: Template.projectName, with: projectName)
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
        
        var newContent = content.replacingOccurrences(of: Template.projectName, with: settings.name)
        newContent = newContent.replacingOccurrences(of: Template.bundleDomain, with: settings.bundleID)
        newContent = newContent.replacingOccurrences(of: Template.author, with: settings.author)
        newContent = newContent.replacingOccurrences(of: Template.organizationName, with: settings.organizationName)
        
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
    
    public var artifactsDirectoryURL: NSURL {
        return NSURL(fileURLWithPath: "Artifacts", relativeTo: runScriptPathURL.toURL)
    }
    
    func projectTemplateURL(type: ArchitectureType) -> NSURL {
        return NSURL(fileURLWithPath: "Template/\(type.rawValue)/\(Template.projectName)", relativeTo: runScriptPathURL.toURL)
    }
    
    func generatedDirectoryURL(settings: ProjectSettings) -> NSURL {
        return NSURL(fileURLWithPath: settings.name, relativeTo: artifactsDirectoryURL.toURL)
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
    private lazy var dialogue = Dialogue(settings: projectSettings)
    
    private var projectSettings = ProjectSettings(architecture: .empty,
                                                  name: "ProjectName",
                                                  bundleID: "com.abcd.Hello",
                                                  author: "AuthorName",
                                                  organizationName: "OrganizationName")
    
    private var newURL: URL {
        return filepath.generatedDirectoryURL(settings: projectSettings).toURL
    }
    
    
    
    public func start() {
        
        print("\nLet's go over some question to generate your base project code!")
        
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
        bootProject()
    }
    
    private func copyTemplateFolder() {
        do {
            let templateURL = filepath.projectTemplateURL(type: projectSettings.architecture).toURL
            try filepath.fileManager.copyItem(at: templateURL, to: newURL)
        } catch let error as NSError {
            Console.printErrorAndExit(message: error.localizedDescription)
        }
    }
    
    private func rename() {
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
    
    private func bootProject() {
        print("\nSetting \(projectSettings.name) ...")
        print(Console.shell(path: newURL.path, args: "sh", "bootstrap.sh").output)
    }
    
}

Main().start()
