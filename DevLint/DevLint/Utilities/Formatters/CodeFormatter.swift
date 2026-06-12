//
//  CodeFormatter.swift
//  DevLint
//
//  Created by CS Prasad on 17/03/25.
//

import Foundation

// MARK: - CodeFormatter Protocol to make formatting engine replaceable
protocol CodeFormatter {
    func format(code: String) throws -> String
}

// MARK: - Formatter Manager to allow easy switching
class FormatterManager {
    static let shared = FormatterManager()

    private var formatter: CodeFormatter

    init(formatter: CodeFormatter = SwiftFormatAdapter()) {
        self.formatter = formatter
    }

    /// Format the provided source code using the configured formatter.
    /// - Parameter code: The source code to format.
    /// - Returns: The formatted source code. If formatting fails, returns the original `code`.
    func format(code: String) -> String {
        do {
            return try formatter.format(code: code)
        } catch let error as FormatterError {
            print(error.localizedDescription)
            return code // Return unformatted code if formatting fails
        } catch {
            print("Unexpected formatting error: \(error.localizedDescription)")
            return code
        }
    }
}

// MARK: - Define a custom error type for format failures
enum FormatterError: Error {
    case formattingFailed(String)

    var localizedDescription: String {
        switch self {
        case .formattingFailed(let message):
            return "Formatting Error: \(message)"
        }
    }
}
