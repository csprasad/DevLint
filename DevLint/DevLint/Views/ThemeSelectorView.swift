//
//  ThemeSelectorView.swift
//  DevLint
//
//  Created by CS Prasad on 07/03/25.
//

import SwiftUI

struct ThemeSelectorView: View {
    @ObservedObject var themeManager: ThemeManager

    var body: some View {
        HStack {
            Text("DevLint - Swift Code Formatter")
                .font(.system(.largeTitle).monospaced())

            Spacer()

            Picker("Theme", selection: $themeManager.currentTheme) {
                ForEach(themeManager.themes) { theme in
                    Text(theme.name)
                        .tag(theme)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .frame(width: 150)

            Toggle("Dark Mode", isOn: $themeManager.isDarkMode)
                .onChange(of: themeManager.isDarkMode) { newValue in
                    print("Dark mode changed to: \(newValue)")
                    themeManager.updateThemeForDarkMode()
                    themeManager.applyAppearance()
                }
        }
        .padding()
    }
}
