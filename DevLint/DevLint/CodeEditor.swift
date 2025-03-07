//
//  CodeEditor.swift
//  DevLint
//
//  Created by CS Prasad on 23/02/25.
//

import AppKit
import SwiftUI

struct CodeEditor: NSViewRepresentable {
    @Binding var text: String
    let isEditable: Bool

    func makeNSView(context _: Context) -> NSScrollView {
        let scrollView = NSScrollView()
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false

        let textView = NSTextView()
        textView.isEditable = isEditable
        textView.font = NSFont.monospacedSystemFont(ofSize: 14, weight: .regular)
        textView.backgroundColor = .black
        textView.textColor = .white
        textView.textContainer?.widthTracksTextView = true

        scrollView.documentView = textView

        // 🔹 Add Line Number View INSIDE CodeEditor
//        let lineNumberView = LineNumberView(textView: textView)
//        scrollView.contentView.addSubview(lineNumberView)
//
//        // Position the line number view
//        lineNumberView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            lineNumberView.leadingAnchor.constraint(equalTo: scrollView.contentView.leadingAnchor),
//            lineNumberView.topAnchor.constraint(equalTo: scrollView.contentView.topAnchor),
//            lineNumberView.bottomAnchor.constraint(equalTo: scrollView.contentView.bottomAnchor),
//            lineNumberView.widthAnchor.constraint(equalToConstant: 40),
//        ])

        return scrollView
    }

    func updateNSView(_ nsView: NSScrollView, context _: Context) {
        guard let textView = nsView.documentView as? NSTextView else { return }

        let selectedRange = textView.selectedRange() // Preserve cursor position

        if textView.string != text {
            textView.string = text
        }

        let attributedString = NSMutableAttributedString(string: textView.string)
        SyntaxHighlighter.highlight(attributedString, textView.effectiveAppearance)

        textView.textStorage?.beginEditing()
        textView.textStorage?.setAttributedString(attributedString)
        textView.textStorage?.endEditing()

        textView.setSelectedRange(selectedRange) // Restore cursor position
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: CodeEditor
        weak var textView: NSTextView?

        init(_ parent: CodeEditor) {
            self.parent = parent
        }

        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else { return }

            if parent.text != textView.string {
                parent.text = textView.string
            }
        }
    }
}
