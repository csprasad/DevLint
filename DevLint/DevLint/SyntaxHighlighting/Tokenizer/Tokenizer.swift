//
//  Tokenizer.swift
//  DevLint
//
//  Created by CS Prasad on 18/03/25.
//

import Foundation

/// Tokenizer responsible for breaking source code into tokens.
class Tokenizer {
    private let code: String
    private var position: String.Index
    
    init(code: String) {
        self.code = code
        self.position = code.startIndex
    }
    
    /// Tokenizes the given source code and returns an array of tokens.
    func tokenize() -> [Token] {
        var tokens: [Token] = []
        
        while position < code.endIndex {
            if let token = nextToken() {
                tokens.append(token)
            }
        }
        
        return tokens
    }
    
    /// Reads the next token from the source code.
    private func nextToken() -> Token? {
        let currentChar = code[position]
        
        // Skip whitespace
        if currentChar.isWhitespace {
            advance()
            return Token(type: .whitespace, value: String(currentChar), range: NSRange(location: 0, length: 1))
        }
        
        // Identify token types
        if currentChar.isNumber {
            return readNumber()
        } else if currentChar.isLetter {
            return readIdentifierOrKeyword()
        } else if currentChar == "\"" {
            return readString()
        } else if currentChar == "'" {
            return readCharacterLiteral()
        } else if isOperator(currentChar) {
            return readOperator()
        } else if isPunctuation(currentChar) {
            return readPunctuation()
        } else if currentChar == "/" && peekNext() == "/" {
            return readSingleLineComment()
        } else if currentChar == "/" && peekNext() == "*" {
            return readMultiLineComment()
        } else if currentChar == "@" {
            return readAnnotation()
        } else if currentChar == "#" {
            return readPreprocessorDirective()
        } else if currentChar == "<" {
            return readGenericType()
        } else if currentChar == "/" {
            return readRegexLiteral()
        }
        
        // Handle unknown token
        advance()
        return Token(type: .unknown, value: String(currentChar), range: NSRange(location: 0, length: 1))
    }
    
    /// Reads numbers, including hexadecimal, binary, and octal.
    private func readNumber() -> Token {
        var value = ""

        if code[position] == "0" {
            advance()
            if position < code.endIndex {
                let nextChar = code[position]
                if nextChar == "x" {
                    return readHexNumber()
                } else if nextChar == "b" {
                    return readBinaryNumber()
                } else if nextChar == "o" {
                    return readOctalNumber()
                }
            }
        }

        while position < code.endIndex, code[position].isNumber {
            value.append(code[position])
            advance()
        }

        return Token(type: .number, value: value, range: NSRange(location: 0, length: value.count))
    }

    
    /// Reads interpolated strings like "Hello \(name)!".
    private func readString() -> Token {
        var value = "\""
        advance()
        
        while position < code.endIndex, code[position] != "\"" {
            if code[position] == "\\" && peekNext() == "(" {
                value.append("\\(")
                advance()
                advance()
                while position < code.endIndex, code[position] != ")" {
                    value.append(code[position])
                    advance()
                }
                advance()
                value.append(")")
            } else {
                value.append(code[position])
                advance()
            }
        }
        advance()
        value.append("\"")
        
        return Token(type: .string, value: value, range: NSRange(location: 0, length: value.count))
    }
    
    /// Reads character literals.
    private func readCharacterLiteral() -> Token {
        var value = ""
        advance() // Skip opening quote
        
        while position < code.endIndex, code[position] != "'" {
            value.append(code[position])
            advance()
        }
        advance() // Skip closing quote
        
        return Token(type: .character, value: value, range: NSRange(location: 0, length: value.count))
    }
    
    /// Reads regex literals /pattern/.
    private func readRegexLiteral() -> Token {
        var value = ""
        advance()
        
        while position < code.endIndex, code[position] != "/" {
            value.append(code[position])
            advance()
        }
        advance()
        
        return Token(type: .regexLiteral, value: value, range: NSRange(location: 0, length: value.count))
    }
    
    /// Reads generic types like <T>.
    private func readGenericType() -> Token {
        var value = ""
        
        while position < code.endIndex, code[position] != ">" {
            value.append(code[position])
            advance()
        }
        advance()
        
        return Token(type: .genericType, value: "<" + value + ">", range: NSRange(location: 0, length: value.count))
    }
    
    /// Reads identifiers, keywords, boolean literals, or null literals.
    private func readIdentifierOrKeyword() -> Token {
        var value = ""
        
        while position < code.endIndex, code[position].isLetter {
            value.append(code[position])
            advance()
        }
        
        // Check if it's a keyword (expandable list)
        // Check if it's a keyword (expanded list for multiple languages)
        let keywords: Set<String> = [
            // Swift
            "func", "var", "let", "if", "else", "return", "class", "struct", "enum", "protocol", "extension", "import", "guard", "do", "catch", "throw", "throws", "try", "defer", "break", "continue", "switch", "case", "default", "fallthrough", "in", "repeat", "while", "for", "where", "as", "is", "super", "self", "init", "deinit", "subscript", "operator", "typealias", "associatedtype", "static", "final", "override", "private", "fileprivate", "internal", "public", "open", "mutating", "nonmutating", "lazy", "weak", "unowned", "indirect", "convenience", "required", "optional", "dynamic", "some", "any",
            
            // Python
            "def", "lambda", "return", "if", "elif", "else", "try", "except", "finally", "raise", "for", "while", "break", "continue", "pass", "class", "import", "from", "as", "global", "nonlocal", "with", "assert", "yield", "del", "or", "and", "not", "is", "in", "async", "await",
            
            // JavaScript
            "function", "var", "let", "const", "if", "else", "return", "switch", "case", "default", "for", "while", "do", "break", "continue", "try", "catch", "finally", "throw", "class", "extends", "constructor", "import", "export", "super", "this", "new", "typeof", "instanceof", "void", "yield", "async", "await", "static", "public", "private", "protected",
            
            // C++
            "int", "double", "float", "char", "bool", "void", "if", "else", "switch", "case", "default", "for", "while", "do", "break", "continue", "return", "class", "struct", "union", "namespace", "using", "typedef", "template", "new", "delete", "this", "friend", "operator", "virtual", "override", "final", "explicit", "mutable", "const", "constexpr", "volatile", "static", "extern", "inline", "goto", "sizeof", "enum", "public", "private", "protected"
        ]
        
        let type: Token.TokenType
        if keywords.contains(value) {
            type = .keyword
        } else if value == "true" || value == "false" {
            type = .boolean
        } else if value == "null" || value == "nil" {
            type = .nullLiteral
        } else if value.hasPrefix("`") && value.hasSuffix("`") {
            type = .escapedIdentifier
        } else {
            type = .identifier
        }
        
        return Token(type: type, value: value, range: NSRange(location: 0, length: value.count))
    }
    
    /// Reads operators.
    private func readOperator() -> Token {
        let value = String(code[position])
        advance()
        return Token(type: .operatorSymbol, value: value, range: NSRange(location: 0, length: value.count))
    }
    
    /// Reads punctuation.
    private func readPunctuation() -> Token {
        let value = String(code[position])
        advance()
        return Token(type: .punctuation, value: value, range: NSRange(location: 0, length: value.count))
    }
    
    /// Reads single-line comments.
    private func readSingleLineComment() -> Token {
        var value = ""
        while position < code.endIndex, code[position] != "\n" {
            value.append(code[position])
            advance()
        }
        return Token(type: .comment, value: value, range: NSRange(location: 0, length: value.count))
    }
    
    /// Reads multi-line comments.
    private func readMultiLineComment() -> Token {
        var value = ""
        while position < code.endIndex, !(code[position] == "*" && peekNext() == "/") {
            value.append(code[position])
            advance()
        }
        advance() // Move past '*'
        advance() // Move past '/'
        return Token(type: .comment, value: value, range: NSRange(location: 0, length: value.count))
    }
    
    /// Moves to the next character in the source code.
    private func advance() {
        position = code.index(after: position)
    }
    
    
    /// Peeks at the next character without consuming it.
    private func peekNext() -> Character? {
        let nextIndex = code.index(after: position)
        return nextIndex < code.endIndex ? code[nextIndex] : nil
    }
    
    /// Checks if a character is an operator.
    private func isOperator(_ char: Character) -> Bool {
        return "+-*/=<>!&|^%".contains(char)
    }
    
    /// Checks if a character is punctuation.
    private func isPunctuation(_ char: Character) -> Bool {
        return ",;:.(){}[]".contains(char)
    }
    
    /// Reads annotations (e.g., @objc, @Test).
    private func readAnnotation() -> Token {
        var value = ""
        
        while position < code.endIndex, code[position].isLetter || code[position] == "@" {
            value.append(code[position])
            advance()
        }
        
        return Token(type: .annotation, value: value, range: NSRange(location: 0, length: value.count))
    }
    
    /// Reads preprocessor directives (e.g., #define, #import).
    private func readPreprocessorDirective() -> Token {
        var value = ""
        
        while position < code.endIndex, code[position].isLetter || code[position] == "#" {
            value.append(code[position])
            advance()
        }
        
        return Token(type: .preprocessorDirective, value: value, range: NSRange(location: 0, length: value.count))
    }
    
    /// Reads hex number (e.g., 0xFF, 0x1A)
    private func readHexNumber() -> Token {
        var value = "0x"
        advance() // Skip 'x'

        while position < code.endIndex, code[position].isHexDigit {
            value.append(code[position])
            advance()
        }

        return Token(type: .hexNumber, value: value, range: NSRange(location: 0, length: value.count))
    }

    /// Reads Binary number (e.g., 0b1010, 0b1101)
    private func readBinaryNumber() -> Token {
        var value = "0b"
        advance() // Skip 'b'

        while position < code.endIndex, "01".contains(code[position]) {
            value.append(code[position])
            advance()
        }

        return Token(type: .binaryNumber, value: value, range: NSRange(location: 0, length: value.count))
    }

    /// Reads Octal number (e.g., 0o77, 0o123)
    private func readOctalNumber() -> Token {
        var value = "0o"
        advance() // Skip 'o'

        while position < code.endIndex, "01234567".contains(code[position]) {
            value.append(code[position])
            advance()
        }

        return Token(type: .octalNumber, value: value, range: NSRange(location: 0, length: value.count))
    }


}
