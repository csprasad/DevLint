//
//  Token.swift
//  DevLint
//
//  Created by CS Prasad on 18/03/25.
//

import Foundation

/// Represents a single token in the source code.
struct Token {
    enum TokenType {
        case keyword                // e.g., func, var, let, if, else
        case identifier             // Variable and function names
        case number                 // Integers, floats, etc.
        case string                 // "Hello, World!"
        case interpolatedString      // "Hello \(name)!"
        case character              // 'A', 'B', etc.
        case boolean                // true, false
        case operatorSymbol         // +, -, *, /, =, ==, !=, etc.
        case punctuation            // { }, ( ), [ ], ; , . , ,
        case comment                // // Single-line, /* Multi-line */
        case directive              // #if, #endif, #define (Preprocessor directives)
        case whitespace             // Spaces, tabs, newlines
        case newline                // Line breaks
        case escapeSequence         // \n, \t, etc.
        case annotation             // @available, @objc, etc.
        case type                   // Int, String, Double, custom class names
        case accessModifier         // public, private, internal, protected
        case storageModifier        // static, final, override, mutating
        case functionCall           // print(), customFunction()
        case macro                  // #macro (used in some languages)
        case unknown                // Fallback category for anything unrecognized
        case nullLiteral            // null, nil
        case preprocessorDirective  // Preprocessor directives like #define, #import
        case escapedIdentifier      // Backtick-wrapped names (`reserved`)
        case hexNumber              // 0xFF, 0x1A
        case binaryNumber           // 0b1010, 0b1101
        case octalNumber            // 0o77, 0o123
        case regexLiteral           // /pattern/ (used in JS, Swift 5.7+)
        case genericType            // <T>, <Key, Value>
    }
    
    let type: TokenType   // The category of this token
    let value: String     // The actual text of the token
    let range: NSRange    // Position in the source code
}
