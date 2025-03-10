//
//  CustomToolbar.swift
//  DevLint
//
//  Created by CS Prasad on 10/03/25.
//

import SwiftUI
struct CustomToolbar: View {
    @ObservedObject var themeManager: ThemeManager
    @ObservedObject var viewModel: CodeEditorViewModel
    @Binding var isFormatting: Bool

    var body: some View {
        HStack(spacing: 12) {
            HStack {
                Text("Enter Code")
                    .font(themeManager.currentTheme.font)
                Spacer()
                
                Picker("Theme", selection: $themeManager.currentTheme) {
                    ForEach(themeManager.availableThemes) { theme in
                        Text(theme.name)
                            .tag(theme)
                    }
                }
                .font(themeManager.currentTheme.font)
                .pickerStyle(MenuPickerStyle())
                .frame(width: 150)
                
                ToolbarButton(icon: themeManager.isDarkMode ? "sun.max.fill" : "moon.fill", tooltip: "Dark mode toggle", action: {
                    themeManager.isDarkMode.toggle()
                })

                // TODO:  Implement share button logic
//                ToolbarButton(icon: "square.and.arrow.up", tooltip: "Share Code", action: {
//                    // Share Action
//                })

                HStack {
                    // TODO: Link this button to real formating logic to show progress.. currently it just a showcase
                    ToolbarButton(icon: "wand.and.stars", text: "Format", tooltip: "Format Code", action: {
                        isFormatting = true
                        viewModel.formatSwiftCode()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            isFormatting = false
                        }
                    })
                    
                    if isFormatting {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .frame(width: 16, height: 16)
                            .scaleEffect(0.5)
                    }
                }
            }
            
            Spacer(minLength: 0)
            Divider()
            Spacer(minLength: 0)
            
            HStack(spacing: 12) {
                Text("Formatted Code")
                    .font(themeManager.currentTheme.font)
                Spacer()
                ToolbarButton(text: "Copy", tooltip: "Copy formatted code", action: {
                    viewModel.copyToClipboard()
                })
                ToolbarButton(text: "Clear", tooltip: "Clear all code", action: {
                    viewModel.clear()
                })
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 10)
    }
}
