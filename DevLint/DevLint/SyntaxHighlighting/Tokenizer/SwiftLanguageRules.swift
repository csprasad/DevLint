//
//  SwiftLanguageRules.swift
//  DevLint
//
//  Created by CS Prasad on 18/03/25.
//

import Foundation
struct SwiftLanguageRules: LanguageRules {
    let keywords: Set<String> = [
        "class", "deinit", "enum", "extension", "func", "import", "init", "let", "protocol", "struct",
        "subscript", "typealias", "var", "break", "case", "continue", "default", "do", "else",
        "fallthrough", "for", "if", "in", "return", "switch", "where", "while", "as", "catch",
        "is", "rethrows", "super", "self", "throw", "throws", "try", "_", "associatedtype",
        "convenience", "didSet", "get", "guard", "indirect", "inout", "lazy", "nonmutating",
        "optional", "required", "set", "some", "unowned", "weak", "willSet", "actor", "async",
        "await"
    ]
    let identifiers: Set<String> = [] // Variable/function names identified dynamically
    let numbers: Set<String> = [] // Handled via regex (e.g., 123)
    let decimalNumbers: Set<String> = [] // Handled via regex (e.g., 45.6)
    let exponentNumbers: Set<String> = [] // Handled via regex (e.g., 1e-5)
    let strings: Set<String> = [] // Handled via regex (e.g., "Hello")
    let rawStrings: Set<String> = [] // Handled via regex (e.g., #"Hello"#)
    let multiLineStrings: Set<String> = [] // Handled via regex (e.g., """Hello""")
    let interpolatedStrings: Set<String> = [] // Handled via regex (e.g., "Hello \(name)")
    let characters: Set<String> = [] // Handled via regex (e.g., 'A')
    let booleans: Set<String> = ["true", "false"]
    let operatorSymbols: Set<String> = ["+", "-", "*", "/", "=", "==", "!=", ">", "<", ">=", "<=", "&&", "||", "!", "&", "|", "^", "%"]
    let punctuation: Set<String> = ["{", "}", "(", ")", "[", "]", ";", ".", ","]
    let comments: Set<String> = ["//", "/*", "*/"]
    let directives: Set<String> = [
        "#if", "#else", "#elseif", "#endif", "#error", "#warning", "#define", "#import",
        "#available", "#colorLiteral", "#column", "#dsohandle", "#file", "#fileID", "#fileLiteral",
        "#function", "#imageLiteral", "#keyPath", "#line", "#selector", "#sourceLocation"
    ]
    let escapeSequences: Set<String> = ["\\n", "\\t", "\\r", "\\\""]
    let annotations: Set<String> = ["@available", "@objc"]
    let attributes: Set<String> = ["@available", "@objc"] // Could expand with @MainActor, @escaping, etc.
    let types: Set<String> = ["Int", "String", "Double", "Bool", "Array", "Dictionary"]
    let accessModifiers: Set<String> = ["fileprivate", "internal", "private", "public", "open"]
    let storageModifiers: Set<String> = ["static", "final", "override", "mutating"]
    let functionCalls: Set<String> = [] // Identified dynamically
    let macros: Set<String> = ["#macro"]
    let nullLiterals: Set<String> = ["nil, null"]
    let genericTypes: Set<String> = [] // Identified dynamically (e.g., <T>)
    let escapedIdentifiers: Set<String> = [] // Identified dynamically (e.g., `var`)
    let hexNumbers: Set<String> = [] // Handled via regex (e.g., 0xFF)
    let binaryNumbers: Set<String> = [] // Handled via regex (e.g., 0b1010)
    let octalNumbers: Set<String> = [] // Handled via regex (e.g., 0o77)
    let regexLiterals: Set<String> = [] // Handled via regex (e.g., /pattern/)
    let shebang: Set<String> = [] // Handled via regex (e.g., #!/usr/bin/swift)
    let parameterLabels: Set<String> = [] // Identified dynamically (e.g., for: in func foo(for: Int))
    let tupleTypes: Set<String> = [] // Identified dynamically (e.g., (Int, String))
    let metatypes: Set<String> = [] // Could include .Type, .Protocol dynamically
    let keyPaths: Set<String> = [] // Handled via regex (e.g., \Person.name)
    let implicitParameters: Set<String> = [] // Identified dynamically (e.g., $0, $1)
    let dollarIdentifiers: Set<String> = [] // Identified dynamically (e.g., $value)
    let patternMatching: Set<String> = [] // Could include ~=
    let lazyStorage: Set<String> = [] // Lazy handled in keywords, could expand
    let dependencyMacros: Set<String> = [] // For macro system dependencies
    let moduleNames: Set<String> = [] // Identified dynamically (e.g., Swift, Foundation)
    let escapedNewlines: Set<String> = [] // Handled via regex (e.g., line continuation)

    func getTokenType(for value: String) -> Token.TokenType {
        if keywords.contains(value) { return .keyword }
        if booleans.contains(value) { return .boolean }
        if operatorSymbols.contains(value) { return .operatorSymbol }
        if punctuation.contains(value) { return .punctuation }
        if comments.contains(value) { return .comment }
        if directives.contains(value) { return .directive }
        if escapeSequences.contains(value) { return .escapeSequence }
        if annotations.contains(value) { return .annotation }
        if types.contains(value) { return .type }
        if accessModifiers.contains(value) { return .accessModifier }
        if storageModifiers.contains(value) { return .storageModifier }
        if macros.contains(value) { return .macro }
        if nullLiterals.contains(value) { return .nullLiteral }
        return .identifier
    }
}
