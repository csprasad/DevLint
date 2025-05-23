//
//  Theme.swift
//  DevLint
//
//  Created by CS Prasad on 07/03/25.
//

import SwiftUI

struct ThemeModel: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let primaryColor: NSColor
    let secondaryColor: NSColor
    let backgroundColor: NSColor
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
    static func == (lhs: ThemeModel, rhs: ThemeModel) -> Bool {
        lhs.id == rhs.id
    }
}
