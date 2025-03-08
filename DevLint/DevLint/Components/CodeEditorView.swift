//
//  CustomTextEditor.swift
//  DevLint
//
//  Created by CS Prasad on 07/03/25.
//

import AppKit
import SwiftUI

struct CodeEditorView: NSViewRepresentable {
    @Binding var text: String
    @ObservedObject var themeManager: ThemeManager

    func makeNSView(context: Context) -> NSTextView {
        let textView = NSTextView()

        // Configure the text view
        textView.string = text
        textView.isEditable = true
        textView.isSelectable = true
        textView.delegate = context.coordinator
        textView.usesFindBar = true

        // Apply performance optimizations
        optimizeTextView(textView)

        return textView
    }

    func updateNSView(_ textView: NSTextView, context _: Context) {
        if textView.string != text {
            textView.string = text
        }
        
        updateThemeIfNeeded(for: textView)

        let selectedRange = textView.selectedRange()
        asyncSyntaxHighlight(textView)
        textView.setSelectedRange(selectedRange)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: CodeEditorView

        init(_ parent: CodeEditorView) {
            self.parent = parent
        }

        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else { return }
            parent.text = textView.string
        }
    }

    // 🔹 Apply Performance Optimizations
    private func optimizeTextView(_ textView: NSTextView) {
        print(themeManager.currentTheme.name + "theme on text bg")
        let layoutManager = textView.layoutManager
        
        // 🏎️ Enable Lazy Rendering
        layoutManager?.allowsNonContiguousLayout = true

        // 🚀 Improve Scrolling Performance
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = true
        textView.autoresizingMask = [.width, .height]

        // 📏 Disable Line Wrapping
        textView.textContainer?.heightTracksTextView = false
        textView.textContainer?.containerSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        textView.textContainer?.widthTracksTextView = false
        textView.textContainer?.lineBreakMode = .byClipping
    }

    // 🔥 **Asynchronous Syntax Highlighting**
    private func asyncSyntaxHighlight(_ textView: NSTextView) {
        let text = textView.string // Get string on main thread
        let appearance = textView.effectiveAppearance // Get appearance on main thread
        
        DispatchQueue.global(qos: .userInitiated).async {
            let attributedString = NSMutableAttributedString(string: text)
            SyntaxHighlighter.highlight(attributedString, appearance, using: themeManager.currentTheme)

            DispatchQueue.main.async {
                textView.textStorage?.beginEditing()
                textView.textStorage?.setAttributedString(attributedString)
                textView.textStorage?.endEditing()
            }
        }
    }
    
    // 🔥 Update the theme dynamically if necessary (avoiding full reset)
        private func updateThemeIfNeeded(for textView: NSTextView) {
            // Apply the new theme only if it's different from the current one
            if textView.backgroundColor != themeManager.currentTheme.backgroundColor {
                textView.backgroundColor = themeManager.currentTheme.backgroundColor
                textView.textColor = themeManager.currentTheme.primaryColor
                textView.insertionPointColor = themeManager.currentTheme.primaryColor
                textView.font = NSFont.monospacedSystemFont(ofSize: 14, weight: .regular)
            }
        }
}
