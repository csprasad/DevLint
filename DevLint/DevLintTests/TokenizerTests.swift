//
//  TokenizerTests.swift
//  DevLintTests
//
//  Created by CS Prasad on 18/03/25.
//

import XCTest
@testable import DevLint

class TokenizerTests: XCTestCase {
    
    private func assertTokenization(_ input: String, expected: Token.TokenType) {
        let tokenizer = Tokenizer(code: input)
        let tokens = tokenizer.tokenize()
        XCTAssertEqual(tokens.count, 1, "Expected one token but got \(tokens.count)")
        XCTAssertEqual(tokens.first?.type, expected, "Expected \(expected) but got \(tokens.first?.type ?? .unknown)")
    }
    
    
    func testBooleanLiterals() {
        assertTokenization("true", expected: .boolean)
        assertTokenization("false", expected: .boolean)
    }
    
    func testNullLiterals() {
        assertTokenization("nil", expected: .nullLiteral)
        assertTokenization("null", expected: .nullLiteral)
    }
    
    func testAnnotations() {
        assertTokenization("@objc", expected: .annotation)
        assertTokenization("@available", expected: .annotation)
    }
    
    func testPreprocessorDirectives() {
        assertTokenization("#define", expected: .preprocessorDirective)
        assertTokenization("#import", expected: .preprocessorDirective)
    }
    
    func testEscapedIdentifiers() {
        assertTokenization("`reserved`", expected: .escapedIdentifier)
    }
    
    func testHexBinaryOctalNumbers() {
        assertTokenization("0xFF", expected: .hexNumber)
        assertTokenization("0b1010", expected: .binaryNumber)
        assertTokenization("0o77", expected: .octalNumber)
    }
    
    // New test cases for missing token types
    func testKeywords() {
        assertTokenization("func", expected: .keyword)
        assertTokenization("if", expected: .keyword)
    }
    
    func testIdentifiers() {
        assertTokenization("myVariable", expected: .identifier)
        assertTokenization("someFunction", expected: .identifier)
    }
    
    func testNumbers() {
        assertTokenization("123", expected: .number)
        assertTokenization("45.6", expected: .number)
    }
    
    func testStrings() {
        assertTokenization("\"Hello, World!\"", expected: .string)
    }
    
    func testCharacterLiterals() {
        assertTokenization("'A'", expected: .character)
    }
    
    func testEscapeSequences() {
        assertTokenization("\n", expected: .escapeSequence)
        assertTokenization("\t", expected: .escapeSequence)
    }
    
    func testOperators() {
        assertTokenization("+", expected: .operatorSymbol)
        assertTokenization("!=", expected: .operatorSymbol)
    }
    
    func testPunctuation() {
        assertTokenization("(", expected: .punctuation)
        assertTokenization(")", expected: .punctuation)
    }
    
    func testComments() {
        assertTokenization("// This is a comment", expected: .comment)
        assertTokenization("/* Multi-line */", expected: .comment)
    }
    
    func testAccessModifiers() {
        assertTokenization("public", expected: .accessModifier)
        assertTokenization("private", expected: .accessModifier)
    }
    
    func testStorageModifiers() {
        assertTokenization("static", expected: .storageModifier)
        assertTokenization("final", expected: .storageModifier)
    }
    
    func testFunctionCalls() {
        assertTokenization("print()", expected: .functionCall)
        assertTokenization("myFunction()", expected: .functionCall)
    }
    
    func testGenericTypes() {
        assertTokenization("<T>", expected: .genericType)
        assertTokenization("<Key, Value>", expected: .genericType)
    }
    
    func testInterpolatedStrings() {
        assertTokenization("\"Hello \(name)!\"", expected: .interpolatedString)
    }
    
    func testRegexLiterals() {
        assertTokenization("/pattern/", expected: .regexLiteral)
    }
}
