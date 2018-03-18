//
//  AbandonnedString.swift
//  LocalizedStringsCleanerCore
//
//  Created by Henry on 17/03/2018.
//

import Foundation
import RswiftCore

struct LocalizedString {
    let file: String
    let line: Int
    let identifier: String
    
    var rSwiftIdentifier: String {
        let swiftName = SwiftIdentifier(name: identifier).description.replacingOccurrences(of: "`", with: "")
        return "R.string.localizable.\(swiftName)"
    }
}
