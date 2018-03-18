//
//  Reporter.swift
//  SwiftLint
//
//  Created by JP Simard on 9/19/15.
//  Copyright © 2015 Realm. All rights reserved.
//

protocol Reporter: CustomStringConvertible {
    static var identifier: String { get }
    static var isRealtime: Bool { get }
    
    static func generateReport(_ abandonnedStrings: [LocalizedString]) -> String
}

func reporterFrom(identifier: String) throws -> Reporter.Type {
    switch identifier {
    case XcodeReporter.identifier:
        return XcodeReporter.self
    default:
       preconditionFailure("attempting to report with unknown identifier \(identifier)")
    }
}
