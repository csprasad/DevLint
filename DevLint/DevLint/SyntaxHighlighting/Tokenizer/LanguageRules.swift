//
//  LanguageRules.swift
//  DevLint
//
//  Created by CS Prasad on 18/03/25.
//

import Foundation

protocol LanguageRules {
    var keywords: Set<String> { get }            // func, var, let, if, else
    var identifiers: Set<String> { get }         // Variable and function names (not predefined)
    var numbers: Set<String> { get }             // Integers, floats, etc.
    var decimalNumbers: Set<String> { get }      // Floating-point numbers (e.g., 3.14)
    var exponentNumbers: Set<String> { get }     // Scientific notation (e.g., 1.23e10)
    var strings: Set<String> { get }             // "Hello, World!"
    var rawStrings: Set<String> { get }          // #"Hello, World!"#
    var multiLineStrings: Set<String> { get }    // """Hello\nWorld!"""
    var interpolatedStrings: Set<String> { get } // "Hello \(name)!"
    var characters: Set<String> { get }          // 'A', 'B', etc.
    var booleans: Set<String> { get }            // true, false
    var operatorSymbols: Set<String> { get }     // +, -, *, /, =, ==, !=, etc.
    var punctuation: Set<String> { get }         // { }, ( ), [ ], ; , . , ,
    var comments: Set<String> { get }            // //, /* */ (Single/Multi-line)
    var directives: Set<String> { get }          // #if, #endif, #define (Preprocessor directives)
    var escapeSequences: Set<String> { get }     // \n, \t, etc.
    var annotations: Set<String> { get }         // @available, @objc, etc.
    var attributes: Set<String> { get }          // Swift attributes (@available, @objc)
    var types: Set<String> { get }               // Int, String, Double, custom class names
    var accessModifiers: Set<String> { get }     // public, private, internal, protected
    var storageModifiers: Set<String> { get }    // static, final, override, mutating
    var functionCalls: Set<String> { get }       // print(), customFunction()
    var macros: Set<String> { get }              // #macro (Used in some languages)
    var nullLiterals: Set<String> { get }        // null, nil
    var escapedIdentifiers: Set<String> { get }  // Backtick-wrapped names (`reserved`)
    var hexNumbers: Set<String> { get }          // 0xFF, 0x1A
    var binaryNumbers: Set<String> { get }       // 0b1010, 0b1101
    var octalNumbers: Set<String> { get }        // 0o77, 0o123
    var regexLiterals: Set<String> { get }       // /pattern/ (Used in JS, Swift 5.7+)
    var genericTypes: Set<String> { get }        // <T>, <Key, Value>
    var shebang: Set<String> { get }             // #!/usr/bin/swift
    var parameterLabels: Set<String> { get }     // firstName in func greet(firstName name: String)
    var tupleTypes: Set<String> { get }          // (x: Int, y: Int)
    var metatypes: Set<String> { get }           // .Type, .Protocol
    var keyPaths: Set<String> { get }            // \Person.name
    var implicitParameters: Set<String> { get }  // $0, $1 in closures
    var dollarIdentifiers: Set<String> { get }   // $var (Swift internals)
    var patternMatching: Set<String> { get }     // case .some(_)
    var lazyStorage: Set<String> { get }         // _storage variables
    var dependencyMacros: Set<String> { get }    // #if canImport
    var moduleNames: Set<String> { get }         // import MyCustomModule
    var escapedNewlines: Set<String> { get }     // \ at EOL for line continuation

    func getTokenType(for value: String) -> Token.TokenType
}
