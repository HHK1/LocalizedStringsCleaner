//
//  FileAccumulator.swift
//  LocalizedStringsCleanerCore
//
//  Created by Henry on 17/03/2018.
//

import Foundation

struct FileAccumulator {
    
    static func concatenateAllSourceCode(in directories: [String], includeStoryboard: Bool) -> String {
        var extensions = ["h", "m", "swift", "jsbundle"]
        if includeStoryboard {
            extensions.append("storyboard")
        }
        let sourceFiles = FileManager.default.findFilesIn(directories, withExtensions: extensions)
        return sourceFiles.reduce("") { (accumulator, sourceFile) -> String in
            return accumulator + FileManager.default.contentsOfFile(sourceFile)
        }
    }
}
