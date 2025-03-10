//
//  ThemeManager.swift
//  DevLint
//
//  Created by CS Prasad on 07/03/25.
//

import SwiftUI
import AppKit


class ThemeManager: ObservableObject {
    @Published var currentTheme: ThemeModel
    @AppStorage("selectedThemeName") var selectedTheme: String = "Default"
    @AppStorage("isDarkMode") var isDarkMode: Bool = false { // Persists dark mode setting
        didSet {
            updateThemeForDarkMode()
            applyAppearance()
        }
    }
    

    let availableThemes: [ThemeModel] = [
        ThemeModel(
            name: "Default",
            primaryColor: NSColor.black,
            secondaryColor: NSColor.gray,
            backgroundColor: NSColor.white,
            font: .system(size: 14, weight: .regular, design: .monospaced),
            keywordColor: NSColor(hex: "#7089DA"),
            typeColor: NSColor(hex: "#C678DD"),
            operatorColor: NSColor(hex: "#F44747"),
            stringColor: NSColor(hex: "#98C379"),
            numberColor: NSColor(hex: "#D19A66"),
            commentColor: NSColor(hex: "#7E8294"),
            booleanColor: NSColor(hex: "#56B6C2"),
            functionColor: NSColor(hex: "#E5C07B"),
            enumColor: NSColor(hex: "#D19A66"),
            structColor: NSColor(hex: "#C678DD"),
            attributeColor: NSColor(hex: "#D55FDE"),
            preprocessorColor: NSColor(hex: "#E06C75"),
            escapeColor: NSColor(hex: "#D19A66"),
            punctuationColor: NSColor(hex: "#ABB2BF")
        ),
        ThemeModel(
            name: "Dark",
            primaryColor: NSColor(hex: "#D9D9D9"),  // Light gray for readability
            secondaryColor: NSColor(hex: "#2C2C2C"), // Dark secondary color
            backgroundColor: NSColor(hex: "#1D1F21"), // Dark background
            font: .system(size: 14, weight: .regular, design: .monospaced),
            
            keywordColor: NSColor(hex: "#C678DD"),     // Purple for keywords
            typeColor: NSColor(hex: "#56B6C2"),        // Cyan for types
            operatorColor: NSColor(hex: "#E06C75"),    // Red for operators
            stringColor: NSColor(hex: "#98C379"),      // Green for strings
            numberColor: NSColor(hex: "#D19A66"),      // Orange for numbers
            commentColor: NSColor(hex: "#5C6370"),     // Dim gray-blue for comments
            booleanColor: NSColor(hex: "#56B6C2"),     // Cyan for booleans
            functionColor: NSColor(hex: "#61AFEF"),    // Blue for functions
            enumColor: NSColor(hex: "#56B6C2"),        // Cyan for enums
            structColor: NSColor(hex: "#D19A66"),      // Orange for structs
            attributeColor: NSColor(hex: "#C678DD"),   // Purple for attributes
            preprocessorColor: NSColor(hex: "#FF7B72"), // Red for preprocessor directives
            escapeColor: NSColor(hex: "#D19A66"),      // Orange for escape sequences
            punctuationColor: NSColor(hex: "#D9D9D9")
        ),
        ThemeModel(
            name: "Solarized",
            primaryColor: NSColor.yellow,
            secondaryColor: NSColor.green,
            backgroundColor: NSColor(red: 0.99, green: 0.96, blue: 0.89, alpha: 1),
            font: .system(size: 14, weight: .regular, design: .monospaced),
            keywordColor: NSColor(hex: "#268BD2"),
            typeColor: NSColor(hex: "#B58900"),
            operatorColor: NSColor(hex: "#DC322F"),
            stringColor: NSColor(hex: "#2AA198"),
            numberColor: NSColor(hex: "#D33682"),
            commentColor: NSColor(hex: "#586E75"),
            booleanColor: NSColor(hex: "#6C71C4"),
            functionColor: NSColor(hex: "#CB4B16"),
            enumColor: NSColor(hex: "#B58900"),
            structColor: NSColor(hex: "#6C71C4"),
            attributeColor: NSColor(hex: "#859900"),
            preprocessorColor: NSColor(hex: "#D33682"),
            escapeColor: NSColor(hex: "#B58900"),
            punctuationColor: NSColor(hex: "#93A1A1")
        ),
    ]

    init() {
        self.currentTheme = availableThemes[0]
        updateThemeForDarkMode()
    }

    func setTheme(name: String) {
        if let newTheme = availableThemes.first(where: { $0.name == name }) {
            currentTheme = newTheme
            selectedTheme = name
        }
    }

    func updateThemeForDarkMode() {
        setTheme(name: isDarkMode ? "Dark" : "Default")
    }
    
    func applyAppearance() {
        // Force the app to use the selected appearance (dark/light)
        NSApp.appearance = NSAppearance(named: isDarkMode ? .darkAqua : .aqua)
    }
}
