//
//  SyntaxHighlighter.swift
//  DevLint
//
//  Created by CS Prasad on 03/03/25.
//

import AppKit

enum SyntaxHighlighter {
    static func highlight(_ attributedString: NSMutableAttributedString, _ appearance: NSAppearance?) {
        let isDarkMode = appearance?.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
        let defaultTextColor: NSColor = isDarkMode ? .white : .black

        let text = attributedString.string
        let range = NSRange(location: 0, length: text.utf16.count)

        // Default style
        attributedString.addAttribute(.font, value: NSFont.monospacedSystemFont(ofSize: 14, weight: .regular), range: range)
        attributedString.addAttribute(.foregroundColor, value: defaultTextColor, range: range)

//        let patterns: [(String, NSColor)] = [
//            ("\\b(import|struct|class|let|var|func|return|if|else|while|for|switch|case|break|continue)\\b", .systemBlue), // Keywords
//            ("\\b(Int|Double|Float|String|Bool|Array|Dictionary)\\b", .systemPurple), // Types
//            ("[+\\-*/%=&|<>!]+", .systemRed), // Operators
//            ("\"(.*?)\"", .systemGreen), // Strings
//            ("\\b\\d+(?:\\.\\d+)?\\b", .systemOrange), // Numbers
//            ("//[^\n]*|/\\*.*?\\*/", .systemGray), // Comments
//            ("\\b(true|false)\\b", .systemTeal), // Boolean literals
//        ]

        let patterns: [(String, NSColor)] = [
            // Keywords (Functions, Control Flow, Declarations)
            ("\\b(import|struct|class|let|var|func|return|if|else|while|for|switch|case|break|continue|enum|protocol|extension|defer|do|try|catch|throw)\\b", NSColor(hex: "#7089DA")),

            // Type Names (Swift Built-in Types)
            ("\\b(Int|Double|Float|String|Bool|Array|Dictionary|Set|Optional)\\b", NSColor(hex: "#C678DD")),

            // Operators (+, -, *, /, &&, ||, etc.)
            ("[+\\-*/%=&|<>!~^]+", NSColor(hex: "#F44747")),

            // Strings (Normal and Raw)
            ("#?\"(.*?)\"#?", NSColor(hex: "#98C379")),

            // Numbers (Integers and Floating-Point)
            ("\\b\\d+(?:\\.\\d+)?\\b", NSColor(hex: "#D19A66")),

            // Boolean Literals (true, false, nil)
            ("\\b(true|false|nil)\\b", NSColor(hex: "#56B6C2")),

            // Comments (Single-line and Multi-line)
            ("//.*", NSColor(hex: "#7E8294")),
            ("/\\*.*?\\*/", NSColor(hex: "#7E8294")),

            // Attributes (@State, @Binding, @Environment)
            ("@\\b(available|discardableResult|objc|State|Environment|Published|Binding)\\b", NSColor(hex: "#D55FDE")),

            // Preprocessor Directives (#if, #else, #endif)
            ("#\\b(if|else|elseif|endif|warning|error|selector|function|line|file|sourceLocation)\\b", NSColor(hex: "#E06C75")),

            // Escape Sequences (\n, \t, Unicode Characters)
            ("\\\\(n|t|r|0|u\\{[0-9A-Fa-f]+\\})", NSColor(hex: "#D19A66")),

            // Function Names (Custom Function Highlighting)
            ("\\b[a-zA-Z_][a-zA-Z0-9_]*\\s*\\(", NSColor(hex: "#E5C07B")),

            // Enum Cases (e.g., .caseOne)
            ("\\bcase\\s+[a-zA-Z_][a-zA-Z0-9_]*", NSColor(hex: "#D19A66")),

            // Struct, Class, Protocol Names
            ("\\b(struct|class|protocol)\\s+[A-Za-z_][A-Za-z0-9_]*", NSColor(hex: "#C678DD")),

            // Braces, Parentheses, Commas, Semicolons
            ("[{}\\[\\](),;:]", NSColor(hex: "#ABB2BF")),
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
