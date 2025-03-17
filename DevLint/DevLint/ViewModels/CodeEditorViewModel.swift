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
    @Published var themeManager: ThemeManager
    @Published var formattedCode: String = ""

    init(themeManager: ThemeManager) {
        self.themeManager = themeManager
    }

    func formatSwiftCode() {
        formattedCode = FormatterManager.shared.format(code: inputCode)
    }

    func copyToClipboard() {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(formattedCode, forType: .string)
    }
    
    func clear() {
        inputCode = ""
        formattedCode = ""
    }

    func updateLineNumbers() {
        let lines = inputCode.components(separatedBy: .newlines)
        lineNumbers = Array(1 ... max(lines.count, 50)) // Ensure at least 50 lines are shown
    }
}
