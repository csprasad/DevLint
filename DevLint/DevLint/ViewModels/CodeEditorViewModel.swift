//
//  CodeEditorViewModel.swift
//  DevLint
//
//  Created by CS Prasad on 07/03/25.
//

import Foundation
import SwiftUI

class CodeEditorViewModel: ObservableObject {
    @Published var inputCode: String = """
import UIKit
import Foundation
import Foundation  // Redundant import should be removed

class ExampleClass {
let name:String
init(name:String){self.name=name} // Missing spaces & redundant `self.`

func greet () ->String {
return"Hello, \\(self.name)"} // Bad spacing, redundant `self.`

var computedProperty: Int {
get { return 42 } // `get {}` should be removed
}

func doSomething(){
if let x=Optional(5) {print(x)} // Bad spacing, `if let` should be `guard let`
}
}

"""
    @Published var lineNumbers: [Int] = Array(1 ... 50)
    @Published var formattedCode: String = ""

    /// Formats the current `inputCode` and updates `formattedCode` with the formatted result.
    func formatSwiftCode() {
        formattedCode = FormatterManager.shared.format(code: inputCode)
    }

    /// Copies the current formatted code to the system pasteboard, replacing any existing contents.
    /// - Note: The code is written as plain text to the pasteboard.
    func copyToClipboard() {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(formattedCode, forType: .string)
    }

    /// Clears the editor content and any formatted output by resetting `inputCode` and `formattedCode` to empty strings.
    func clear() {
        inputCode = ""
        formattedCode = ""
    }

    func updateLineNumbers() {
        let lines = inputCode.components(separatedBy: .newlines)
        lineNumbers = Array(1 ... max(lines.count, 50)) // Ensure at least 50 lines are shown
    }
}
