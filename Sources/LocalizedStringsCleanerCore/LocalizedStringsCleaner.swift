//
//  LocalizedStringsCleaner.swift
//  LocalizedStringsCleanerCore
//
//  Created by Henry on 17/03/2018.
//


import Foundation

public final class LocalizedStringsCleaner {
    
    private let arguments: [String]
    
    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }
    
    public func run() throws {
        guard let rootDirectories = getRootDirectories() else {
            print("Please provide the root directory for source code files as a command line argument.")
            return
        }
        
        let includeStoryboard = isOptionalParameterForStoryboardAvailable()
        let sourceCode = FileAccumulator.concatenateAllSourceCode(in: rootDirectories, includeStoryboard: includeStoryboard)
        let stringsFiles = FileManager.default.findFilesIn(rootDirectories, withExtensions: ["strings"])
        let fileParser = StringsParser(stringsFiles: stringsFiles, sourceCode: sourceCode)
        let abandonnedStrings = fileParser.findAbandonedIdentifiers()
        
        if abandonnedStrings.isEmpty {
            print("No abandoned resource strings were detected.")
        }
        else {
            print("Abandoned resource strings were detected:")
            print(XcodeReporter.generateReport(abandonnedStrings))
        }
    }
    
    // MARK: - Engine
    
    func getRootDirectories() -> [String]? {
        var c = [String]()
        for arg in CommandLine.arguments {
            c.append(arg)
        }
        c.remove(at: 0)
        if isOptionalParameterForStoryboardAvailable() {
            c.removeLast()
        }
        if isOptionaParameterForWritingAvailable() {
            c.remove(at: c.index(of: "write")!)
        }
        return c
    }
    
    func isOptionalParameterForStoryboardAvailable() -> Bool {
        return CommandLine.arguments.last == "storyboard"
    }
    
    func isOptionaParameterForWritingAvailable() -> Bool {
        return CommandLine.arguments.contains("write")
    }
}
