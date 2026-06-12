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

    /// Synchronizes the SwiftUI-bound text and theme into the given editor view while preserving the current selection.
    /// 
    /// Updates the view's string when it differs from the bound `text`, refreshes theme-related appearance if needed, and initiates syntax highlighting without changing the user's selection.
    /// - Parameters:
    ///   - textView: The `NSTextView` to update.
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

    /// Configure an `NSTextView` for code-editing performance and no line wrapping.
    /// 
    /// Applies rendering and layout optimizations (lazy/non-contiguous layout), enables flexible resizing to improve scrolling performance, and disables line wrapping so the text container can grow horizontally without clipping lines.
    ///
    /// - Parameter textView: The `NSTextView` to configure.
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
        textView.textContainer?.containerSize = CGSize(width: CGFloat.greatestFiniteMagnitude,
                                                       height: CGFloat.greatestFiniteMagnitude)
        textView.textContainer?.widthTracksTextView = false
        textView.textContainer?.lineBreakMode = .byClipping
    }

    /// Performs syntax highlighting for the given text view on a background queue and applies the resulting attributes on the main thread.
    /// - Parameters:
    ///   - textView: The `NSTextView` whose contents will be highlighted. The function preserves the view's current selection and will abort applying results if the text changes before updates are applied.
    private func asyncSyntaxHighlight(_ textView: NSTextView) {
        guard let textStorage = textView.textStorage else { return }
        let originalText = textStorage.string
        let selectedRange = textView.selectedRange()

        DispatchQueue.global(qos: .userInitiated).async {
            let attributedString = NSMutableAttributedString(string: originalText)

            SyntaxHighlighter.highlight(attributedString, using: themeManager.currentTheme)

            DispatchQueue.main.async {
                guard textView.string == originalText else { return } // Prevent overwriting new edits

                textStorage.beginEditing()
                attributedString.enumerateAttributes(
                    in: NSRange(
                        location: 0,
                        length: attributedString.length
                    )
                ) { attrs, range, _ in
                    textStorage.setAttributes(attrs, range: range)
                }
                textStorage.endEditing()

                // Restore cursor position
                textView.setSelectedRange(selectedRange)
            }
        }
    }

    /// Updates the given text view's colors and font when its background color differs from the current theme.
        /// - Parameter textView: The `NSTextView` whose background color, text color, insertion point color, and font will be synchronized to the current theme if they are out of date.
        private func updateThemeIfNeeded(for textView: NSTextView) {
            if textView.backgroundColor != themeManager.currentTheme.backgroundColor {
                textView.backgroundColor = themeManager.currentTheme.backgroundColor
                textView.textColor = themeManager.currentTheme.primaryColor
                textView.insertionPointColor = themeManager.currentTheme.primaryColor
                textView.font = NSFont.monospacedSystemFont(ofSize: 14, weight: .regular)
            }
        }
}
