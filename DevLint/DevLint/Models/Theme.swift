//
//  Theme.swift
//  DevLint
//
//  Created by CS Prasad on 07/03/25.
//

import SwiftUI

struct Theme: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let primaryColor: Color
    let secondaryColor: Color
    let backgroundColor: Color
    let font: Font

    // Syntax highlighting colors
    let keywordColor: NSColor
    let typeColor: NSColor
    let operatorColor: NSColor
    let stringColor: NSColor
    let numberColor: NSColor
    let commentColor: NSColor
    let booleanColor: NSColor
    let functionColor: NSColor
    let enumColor: NSColor
    let structColor: NSColor
    let attributeColor: NSColor
    let preprocessorColor: NSColor
    let escapeColor: NSColor
    let punctuationColor: NSColor

    // Implement Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    // Implement Equatable conformance
    static func == (lhs: Theme, rhs: Theme) -> Bool {
        return lhs.id == rhs.id
    }
}
