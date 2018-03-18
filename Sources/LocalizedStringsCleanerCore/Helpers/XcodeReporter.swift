//
//  XcodeReporter.swift
//  SwiftLint
//
//  Created by JP Simard on 9/19/15.
//  Copyright © 2015 Realm. All rights reserved.
//

struct XcodeReporter: Reporter {
    public static let identifier = "xcode"
    public static let isRealtime = true
    
    var description: String {
        return "Reports violations in the format Xcode uses to display in the IDE. (default)"
    }
    
    static func generateReport(_ abandonnedStrings: [LocalizedString]) -> String {
        return abandonnedStrings.map({ generate(for: $0) }).joined(separator: "\n")
    }
    
    internal static func generate(for abandonnedString: LocalizedString) -> String {
        // {full_path_to_file}{:line}{:character}: {error,warning}: {content}
        return [
            "\(abandonnedString.file)",
            ":\(abandonnedString.line): ",
            "warning: ",
            "Unused resource: \(abandonnedString.identifier)"
            ].joined()
    }
}
