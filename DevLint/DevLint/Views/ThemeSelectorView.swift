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

            Picker("Theme", selection: Binding(
                get: { themeManager.currentTheme.name },
                set: { newTheme in themeManager.setTheme(name: newTheme) }
            )) {
                ForEach(themeManager.themes, id: \.name) { theme in
                    Text(theme.name).tag(theme.name)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .frame(width: 150)

            Toggle("Dark Mode", isOn: $themeManager.isDarkMode)
                .onChange(of: themeManager.isDarkMode) { _ in
                    themeManager.toggleDarkMode()
                }
        }
        .padding()
    }
}
