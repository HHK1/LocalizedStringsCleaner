//
//  StringsParser.swift
//  LocalizedStringsCleanerCore
//
//  Created by Henry on 17/03/2018.
//

import Foundation

private let doubleQuote = "\""

public struct StringsParser {
    
    let dispatchGroup = DispatchGroup.init()
    let serialWriterQueue = DispatchQueue.init(label: "writer")
    let stringsFiles: [String]
    let sourceCode: String
    
    init(stringsFiles: [String], sourceCode: String) {
        self.stringsFiles = stringsFiles
        self.sourceCode = sourceCode
    }
    
    func findAbandonedIdentifiers() -> [LocalizedString] {
        var abandonnedStrings = [LocalizedString]()
        for stringsFile in stringsFiles {
            dispatchGroup.enter()
            DispatchQueue.global().async {
                let abandonedIdentifiers = self.findStringIdentifiers(in: stringsFile, abandonedBy: self.sourceCode)
                if !abandonedIdentifiers.isEmpty {
                    self.serialWriterQueue.async {
                        abandonnedStrings.append(contentsOf: abandonedIdentifiers)
                        self.dispatchGroup.leave()
                    }
                } else {
                    print("\(stringsFile) has no abandonedIdentifiers")
                    self.dispatchGroup.leave()
                }
            }
        }
        dispatchGroup.wait()
        return abandonnedStrings
    }

    // MARK: - Identifier extraction
    
    private func findStringIdentifiers(in stringsFile: String, abandonedBy sourceCode: String) -> [LocalizedString] {
        return extractStringIdentifiers(from: stringsFile).filter { !sourceCode.contains($0.rSwiftIdentifier) }
    }
    
    private func extractStringIdentifiers(from stringsFile: String) -> [LocalizedString] {
        return FileManager.default.contentsOfFile(stringsFile)
            .components(separatedBy: "\n")
            .map    { $0.trimmingCharacters(in: CharacterSet.whitespaces) }
            .enumerated().flatMap({ (lineNumber, line) -> LocalizedString? in
                guard line.hasPrefix(doubleQuote) else { return nil }
                let identifier = extractStringIdentifierFromTrimmedLine(line)
                return LocalizedString(file: stringsFile, line: lineNumber, identifier: identifier)
            })
    }
    
    private func extractStringIdentifierFromTrimmedLine(_ line: String) -> String {
        let indexAfterFirstQuote = line.index(after: line.startIndex)
        let lineWithoutFirstQuote = line[indexAfterFirstQuote...]
        let endIndex = lineWithoutFirstQuote.index(of:"\"")!
        let identifier = lineWithoutFirstQuote[..<endIndex]
        return String(identifier)
    }
}
