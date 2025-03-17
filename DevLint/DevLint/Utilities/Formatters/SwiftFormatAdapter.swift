//
//  SwiftFormatAdapter.swift
//  DevLint
//
//  Created by CS Prasad on 17/03/25.
//

import SwiftFormat

//MARK: - SwiftFormat Adapter (Nick Lockwood's SwiftFormat)
class SwiftFormatAdapter: CodeFormatter {
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
