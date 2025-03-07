//
//  ThemeManager.swift
//  DevLint
//
//  Created by CS Prasad on 07/03/25.
//

import SwiftUI

class ThemeManager: ObservableObject {
    @Published var currentTheme: Theme
    @AppStorage("isDarkMode") var isDarkMode: Bool = false // Persists dark mode setting
    @AppStorage("selectedThemeName") var selectedThemeName: String = "Default"

    let themes: [Theme] = [
        Theme(
            name: "Default",
            primaryColor: .blue,
            secondaryColor: .gray,
            backgroundColor: .white,
            font: .system(.body, design: .monospaced),
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
        Theme(
            name: "Dark",
            primaryColor: .white,
            secondaryColor: .gray,
            backgroundColor: .black,
            font: .system(.body, design: .monospaced),
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
        Theme(
            name: "Solarized",
            primaryColor: .yellow,
            secondaryColor: .green,
            backgroundColor: Color(red: 0.99, green: 0.96, blue: 0.89),
            font: .system(.body, design: .monospaced),
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
        currentTheme = themes.first { $0.name == selectedThemeName } ?? themes[0]
        updateThemeForDarkMode()
    }

    func setTheme(name: String) {
        if let newTheme = themes.first(where: { $0.name == name }) {
            currentTheme = newTheme
            selectedThemeName = name
        }
    }

    func toggleDarkMode() {
        isDarkMode.toggle()
        updateThemeForDarkMode()
    }

    func updateThemeForDarkMode() {
        if isDarkMode {
            setTheme(name: "Dark")
        } else {
            setTheme(name: "Default")
        }
    }
}
