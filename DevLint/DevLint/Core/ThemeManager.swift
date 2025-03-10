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
            primaryColor: NSColor.white,
            secondaryColor: NSColor.gray,
            backgroundColor: NSColor.black,
            font: .system(size: 14, weight: .regular, design: .monospaced),
            keywordColor: NSColor(hex: "#FF79C6"),
            typeColor: NSColor(hex: "#8BE9FD"),
            operatorColor: NSColor(hex: "#FF5555"),
            stringColor: NSColor(hex: "#50FA7B"),
            numberColor: NSColor(hex: "#BD93F9"),
            commentColor: NSColor(hex: "#6272A4"),
            booleanColor: NSColor(hex: "#FFB86C"),
            functionColor: NSColor(hex: "#F1FA8C"),
            enumColor: NSColor(hex: "#8BE9FD"),
            structColor: NSColor(hex: "#BD93F9"),
            attributeColor: NSColor(hex: "#FF79C6"),
            preprocessorColor: NSColor(hex: "#FF5555"),
            escapeColor: NSColor(hex: "#BD93F9"),
            punctuationColor: NSColor(hex: "#FFFFFF")
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
