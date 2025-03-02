//
//  DevLintApp.swift
//  DevLint
//
//  Created by CS Prasad on 23/02/25.
//

import SwiftUI

@main
struct DevLintApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_: Notification) {
        if let screen = NSScreen.main {
            let screenSize = screen.visibleFrame.size

            if let window = NSApplication.shared.windows.first {
                window.setContentSize(NSSize(width: 940, height: 750)) // Set default size
                // Set min and max size based on screen
                window.minSize = NSSize(width: 800, height: 620)
                window.maxSize = screenSize // Prevents resizing beyond screen size
            }
        }
    }
}
