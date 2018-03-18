//
//  FileManager+LocalizedStringsCleaner.swift
//  LocalizedStringsCleanerCore
//
//  Created by Henry on 17/03/2018.
//

import Foundation

extension FileManager {
    
    func findFilesIn(_ directories: [String], withExtensions extensions: [String]) -> [String] {
        var files = [String]()
        for directory in directories {
            guard let enumerator: FileManager.DirectoryEnumerator = enumerator(atPath: directory) else {
                print("Failed to create enumerator for directory: \(directory)")
                return files
            }
            while let path = enumerator.nextObject() as? String {
                let fileExtension = (path as NSString).pathExtension.lowercased()
                if extensions.contains(fileExtension) {
                    let fullPath = (directory as NSString).appendingPathComponent(path)
                    files.append(fullPath)
                }
            }
        }
        return files
    }
    
    func contentsOfFile(_ filePath: String) -> String {
        do {
            return try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
        }
        catch { return "" }
    }
}
