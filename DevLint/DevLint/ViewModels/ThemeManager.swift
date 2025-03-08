//
//  ThemeManager.swift
//  DevLint
//
//  Created by CS Prasad on 07/03/25.
//

import SwiftUI
import AppKit


class ThemeManager: ObservableObject {
    @Published var currentTheme: Theme{
        didSet {
            print("currentTheme updated to: \(currentTheme.name)")
        }
    }
    @AppStorage("isDarkMode") var isDarkMode: Bool = false // Persists dark mode setting
    {
    didSet {
        print("isDarkMode updated to: \(isDarkMode)")
    }
}
    @AppStorage("selectedThemeName") var selectedThemeName: String = "Default"

    let themes: [Theme] = [
        Theme(
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
        Theme(
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
        Theme(
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
        self.currentTheme = themes[0]
        updateThemeForDarkMode()
    }

    func setTheme(name: String) {
        if let newTheme = themes.first(where: { $0.name == name }) {
            currentTheme = newTheme
            selectedThemeName = name
        }
    }

//    func toggleDarkMode() {
//        isDarkMode.toggle()
//        updateThemeForDarkMode()
//        applyAppearance()
//    }

    func updateThemeForDarkMode() {
        setTheme(name: isDarkMode ? "Dark" : "Default")
    }
    
    func applyAppearance() {
        // Force the app to use the selected appearance (dark/light)
        NSApp.appearance = NSAppearance(named: isDarkMode ? .darkAqua : .aqua)
    }
}

// Color extension for Hex conversion
extension NSColor {
    convenience init(hex: String, defaultColor: NSColor = .black) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            self.init(cgColor: defaultColor.cgColor)!
            return
        }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        } else {
            self.init(cgColor: defaultColor.cgColor)!
            return
        }

        self.init(red: r, green: g, blue: b, alpha: a)
    }
}

