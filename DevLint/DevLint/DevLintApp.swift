//
//  DevLintApp.swift
//  DevLint
//
//  Created by CS Prasad on 23/02/25.
//

import SwiftUI

@main
struct DevLintApp: App {
    @StateObject private var themeManager = ThemeManager()

    var body: some Scene {
        WindowGroup {
            ContentView(themeManager: themeManager)
                .frame(minWidth: 800, minHeight: 500) // Default opening size
                .onAppear {
                    themeManager.applyAppearance()
                    if let window = NSApp.windows.first {
                        window.setContentSize(NSSize(width: 800, height: 500)) // Default size
                        window.minSize = NSSize(width: 800, height: 500) // Set min size
                        window.maxSize = NSSize(width: 1600, height: 1000) // Optional max size
                    }
                }
        }
    }
}
