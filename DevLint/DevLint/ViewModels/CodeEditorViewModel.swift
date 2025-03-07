//
//  CodeEditorViewModel.swift
//  DevLint
//
//  Created by CS Prasad on 07/03/25.
//

import Foundation
import SwiftFormat
import SwiftUI

class CodeEditorViewModel: ObservableObject {
    @Published var inputCode: String = "// Write your code here...\n\nfunc helloWorld() {\n    print(\"Hello, World!\")\n}"
    @Published var lineNumbers: [Int] = Array(1 ... 50)
    @Published var themeManager: ThemeManager
    @Published var formattedCode: String = ""

    init(themeManager: ThemeManager) {
        self.themeManager = themeManager
    }

    func formatSwiftCode() {
        print("Format button clicked!") // ✅ Check if this prints
        do {
            let source = try SwiftFormat.format(inputCode)
            formattedCode = source.output
            print("Formatted Output:", formattedCode) // ✅ Debugging
        } catch {
            print("Formatting error: \(error)")
            formattedCode = error.localizedDescription
        }
    }

    func copyToClipboard() {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(formattedCode, forType: .string)
    }

    func updateLineNumbers() {
        let lines = inputCode.components(separatedBy: .newlines)
        lineNumbers = Array(1 ... max(lines.count, 50)) // Ensure at least 50 lines are shown
    }
}
