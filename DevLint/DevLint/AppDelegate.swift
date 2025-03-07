//
//  AppDelegate.swift
//  DevLint
//
//  Created by CS Prasad on 03/03/25.
//

import AppKit

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
