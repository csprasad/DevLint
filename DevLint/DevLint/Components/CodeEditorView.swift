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
        let selectedRange = textView.selectedRange()
        if textView.string != text {
            textView.string = text
        }
        
        updateThemeIfNeeded(for: textView)
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

    //  Apply Performance Optimizations
    private func optimizeTextView(_ textView: NSTextView) {
        print(themeManager.currentTheme.name + "theme on text bg")
        let layoutManager = textView.layoutManager
        
        //  Enable Lazy Rendering
        layoutManager?.allowsNonContiguousLayout = true

        //  Improve Scrolling Performance
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = true
        textView.autoresizingMask = [.width, .height]

        //  Disable Line Wrapping
        textView.textContainer?.heightTracksTextView = false
        textView.textContainer?.containerSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        textView.textContainer?.widthTracksTextView = false
        textView.textContainer?.lineBreakMode = .byClipping
    }

    //  **Asynchronous Syntax Highlighting**
    private func asyncSyntaxHighlight(_ textView: NSTextView) {
        guard let textStorage = textView.textStorage else { return }
        let originalText = textStorage.string
        let selectedRange = textView.selectedRange()

        //  Capture appearance on the main thread BEFORE entering async
        let appearance = textView.effectiveAppearance

        DispatchQueue.global(qos: .userInitiated).async {
            let attributedString = NSMutableAttributedString(string: originalText)
            
            //  Now `appearance` is safe to use inside async block
            SyntaxHighlighter.highlight(attributedString, appearance, using: themeManager.currentTheme)

            DispatchQueue.main.async {
                guard textView.string == originalText else { return } // Prevent overwriting new edits
                
                textStorage.beginEditing()
                attributedString.enumerateAttributes(in: NSRange(location: 0, length: attributedString.length)) { attrs, range, _ in
                    textStorage.setAttributes(attrs, range: range)
                }
                textStorage.endEditing()

                // Restore cursor position
                textView.setSelectedRange(selectedRange)
            }
        }
    }


    
    //TODO: Update the theme dynamically if necessary (avoiding full reset) it not working properly
        private func updateThemeIfNeeded(for textView: NSTextView) {
            if textView.backgroundColor != themeManager.currentTheme.backgroundColor {
                textView.backgroundColor = themeManager.currentTheme.backgroundColor
                textView.textColor = themeManager.currentTheme.primaryColor
                textView.insertionPointColor = themeManager.currentTheme.primaryColor
                textView.font = NSFont.monospacedSystemFont(ofSize: 14, weight: .regular)
            }
        }
}
