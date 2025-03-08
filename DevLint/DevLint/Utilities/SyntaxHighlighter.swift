//
//  SyntaxHighlighter.swift
//  DevLint
//
//  Created by CS Prasad on 03/03/25.
//

import AppKit
import SwiftUI

enum SyntaxHighlighter {
    static func highlight(_ attributedString: NSMutableAttributedString, _ appearance: NSAppearance?, using theme: Theme) {
        let defaultTextColor: NSColor = theme.primaryColor

        let text = attributedString.string
        let range = NSRange(location: 0, length: text.utf16.count)

        // Default style
        let font = NSFont.monospacedSystemFont(ofSize: 14, weight: .regular)
        attributedString.addAttribute(.font, value: font, range: range)
        attributedString.addAttribute(.foregroundColor, value: defaultTextColor, range: range)

        let patterns: [(String, NSColor)] = [
            // Keywords (Functions, Control Flow, Declarations)
            ("\\b(import|struct|class|let|var|func|return|if|else|while|for|switch|case|break|continue|enum|protocol|extension|defer|do|try|catch|throw)\\b", theme.keywordColor),

            // Type Names (Swift Built-in Types)
            ("\\b(Int|Double|Float|String|Bool|Array|Dictionary|Set|Optional)\\b", theme.typeColor),

            // Operators (+, -, *, /, &&, ||, etc.)
            ("[+\\-*/%=&|<>!~^]+", theme.operatorColor),

            // Strings (Normal and Raw)
            ("#?\"(.*?)\"#?", theme.stringColor),

            // Numbers (Integers and Floating-Point)
            ("\\b\\d+(?:\\.\\d+)?\\b", theme.numberColor),

            // Boolean Literals (true, false, nil)
            ("\\b(true|false|nil)\\b", theme.booleanColor),

            // Comments (Single-line and Multi-line)
            ("//.*", theme.commentColor),
            ("/\\*.*?\\*/", theme.commentColor),

            // Attributes (@State, @Binding, @Environment)
            ("@\\b(available|discardableResult|objc|State|Environment|Published|Binding)\\b", theme.attributeColor),

            // Preprocessor Directives (#if, #else, #endif)
            ("#\\b(if|else|elseif|endif|warning|error|selector|function|line|file|sourceLocation)\\b", theme.preprocessorColor),

            // Escape Sequences (\n, \t, Unicode Characters)
            ("\\\\(n|t|r|0|u\\{[0-9A-Fa-f]+\\})", theme.escapeColor),

            // Function Names (Custom Function Highlighting)
            ("\\b[a-zA-Z_][a-zA-Z0-9_]*\\s*\\(", theme.functionColor),

            // Enum Cases (e.g., .caseOne)
            ("\\bcase\\s+[a-zA-Z_][a-zA-Z0-9_]*", theme.enumColor),

            // Struct, Class, Protocol Names
            ("\\b(struct|class|protocol)\\s+[A-Za-z_][A-Za-z0-9_]*",theme.structColor),

            // Braces, Parentheses, Commas, Semicolons
            ("[{}\\[\\](),;:]", theme.punctuationColor),
        ]

        for (pattern, color) in patterns {
            if let regex = try? NSRegularExpression(pattern: pattern, options: [.dotMatchesLineSeparators]) {
                regex.enumerateMatches(in: text, options: [], range: range) { match, _, _ in
                    if let matchRange = match?.range {
                        attributedString.addAttribute(.foregroundColor, value: color, range: matchRange)
                    }
                }
            }
        }
    }
}
