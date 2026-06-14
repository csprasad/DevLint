//
//  SwiftFormatAdapter.swift
//  DevLint
//
//  Created by CS Prasad on 17/03/25.
//

import SwiftFormat

// MARK: - SwiftFormat Adapter (Nick Lockwood's SwiftFormat)
class SwiftFormatAdapter: CodeFormatter {
    /// Formats Swift source code using SwiftFormat default options.
    /// - Parameters:
    ///   - code: The Swift source to format.
    /// - Returns: The formatted source code as a `String`.
    /// - Throws: `FormatterError.formattingFailed(_:)` if formatting fails, with the underlying error message.
    func format(code: String) throws -> String {
        do {
            let options = FormatOptions()
            let formatted = try SwiftFormat.format(code, options: options)
            return formatted.output
        } catch {
            throw FormatterError.formattingFailed(error.localizedDescription)
        }
    }
}
