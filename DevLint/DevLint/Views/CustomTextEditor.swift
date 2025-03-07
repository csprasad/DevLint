//
//  CustomTextEditor.swift
//  DevLint
//
//  Created by CS Prasad on 07/03/25.
//

import AppKit
import Foundation
import SwiftUI

struct CustomTextEditor: NSViewRepresentable {
    @Binding var text: String
    @ObservedObject var themeManager: ThemeManager

    func makeNSView(context: Context) -> NSTextView {
        let textView = NSTextView()

        // Configure the text view
        textView.string = text
        textView.isEditable = true
        textView.isSelectable = true
        textView.delegate = context.coordinator

        updateTextViewAppearance(textView)

        // Ensure it resizes properly within the parent ScrollView
        textView.autoresizingMask = [.width, .height]
        textView.minSize = NSSize(width: 0, height: 0)
        textView.maxSize = NSSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)

        return textView
    }

    func updateNSView(_ textView: NSTextView, context _: Context) {
        if textView.string != text {
            textView.string = text
        }

        let selectedRange = textView.selectedRange()

        updateTextViewAppearance(textView)
        let attributedString = NSMutableAttributedString(string: textView.string)
        SyntaxHighlighter.highlight(attributedString, textView.effectiveAppearance)
        textView.textStorage?.beginEditing()
        textView.textStorage?.setAttributedString(attributedString)
        textView.textStorage?.endEditing()

        textView.setSelectedRange(selectedRange)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: CustomTextEditor

        init(_ parent: CustomTextEditor) {
            self.parent = parent
        }

        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else { return }
            parent.text = textView.string
        }
    }

    // Helper function to update the text view appearance
    private func updateTextViewAppearance(_ textView: NSTextView) {
        textView.backgroundColor = NSColor(themeManager.currentTheme.backgroundColor)
        textView.textColor = NSColor(themeManager.currentTheme.primaryColor)
        textView.insertionPointColor = NSColor(themeManager.currentTheme.primaryColor)
        textView.font = NSFont.monospacedSystemFont(ofSize: NSFont.systemFontSize, weight: .regular)
    }
}
