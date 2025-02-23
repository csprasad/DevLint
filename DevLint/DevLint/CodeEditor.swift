//
//  CodeEditorView.swift
//  DevLint
//
//  Created by CS Prasad on 23/02/25.
//

import SwiftUI
import AppKit

struct CodeEditor: NSViewRepresentable {
    @Binding var text: String
    
    func makeNSView(context: Context) -> NSScrollView {
        let scrollView = NSScrollView()
        let textView = NSTextView()
        textView.isAutomaticQuoteSubstitutionEnabled = false
        textView.font = NSFont.monospacedSystemFont(ofSize: 14, weight: .regular)
        textView.delegate = context.coordinator
        textView.isEditable = true
        textView.isSelectable = true
        textView.isRichText = false
        textView.allowsUndo = true
        textView.backgroundColor = .clear
        textView.autoresizingMask = [.width, .height]
        textView.isVerticallyResizable = true
        textView.isHorizontallyResizable = true
        
        scrollView.documentView = textView
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        scrollView.borderType = .bezelBorder
        
        context.coordinator.textView = textView
        
        return scrollView
    }
    
    func updateNSView(_ nsView: NSScrollView, context: Context) {
        if let textView = nsView.documentView as? NSTextView {
            let selectedRange = textView.selectedRange() // Save cursor position

            if textView.string != text {
                textView.textStorage?.setAttributedString(NSAttributedString(string: text))
                context.coordinator.applySyntaxHighlighting()
            }

            textView.setSelectedRange(selectedRange) // Restore cursor position
        }
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
                applySyntaxHighlighting()
            }
            
        }

        
        func applySyntaxHighlighting() {
            guard let textView = textView else { return }
            let attributedString = NSMutableAttributedString(string: textView.string)
            
            let keywords = ["import", "struct", "class", "let", "var", "func", "return", "if", "else", "while", "for", "switch", "case", "break", "continue"]
            let types = ["Int", "Double", "Float", "String", "Bool", "Array", "Dictionary"]
            let operators = "[+\\-*/%=&|<>!]+"
            let stringPattern = "\"(.*?)\""
            let numberPattern = "\\b\\d+(?:\\.\\d+)?\\b"
            let commentPattern = "//.*|/\\*[^*]*\\*+(?:[^/*][^*]*\\*+)*/"
            let booleanLiterals = ["true", "false"]
            
            let keywordRegex = try? NSRegularExpression(pattern: "\\b(" + keywords.joined(separator: "|") + ")\\b", options: [])
            let typeRegex = try? NSRegularExpression(pattern: "\\b(" + types.joined(separator: "|") + ")\\b", options: [])
            let operatorRegex = try? NSRegularExpression(pattern: operators, options: [])
            let stringRegex = try? NSRegularExpression(pattern: stringPattern, options: [])
            let numberRegex = try? NSRegularExpression(pattern: numberPattern, options: [])
            let commentRegex = try? NSRegularExpression(pattern: commentPattern, options: [.dotMatchesLineSeparators])
            let booleanRegex = try? NSRegularExpression(pattern: "\\b(" + booleanLiterals.joined(separator: "|") + ")\\b", options: [])
            
            let range = NSRange(location: 0, length: textView.string.utf16.count)
            
            // Default text color & font
            attributedString.addAttribute(.font, value: NSFont.monospacedSystemFont(ofSize: 14, weight: .regular), range: range)
            attributedString.addAttribute(.foregroundColor, value: NSColor.white, range: range)

            // Apply syntax highlighting
            keywordRegex?.enumerateMatches(in: textView.string, options: [], range: range) { match, _, _ in
                if let matchRange = match?.range {
                    attributedString.addAttribute(.foregroundColor, value: NSColor.systemBlue, range: matchRange)
                }
            }

            typeRegex?.enumerateMatches(in: textView.string, options: [], range: range) { match, _, _ in
                if let matchRange = match?.range {
                    attributedString.addAttribute(.foregroundColor, value: NSColor.systemPurple, range: matchRange)
                }
            }

            operatorRegex?.enumerateMatches(in: textView.string, options: [], range: range) { match, _, _ in
                if let matchRange = match?.range {
                    attributedString.addAttribute(.foregroundColor, value: NSColor.systemRed, range: matchRange)
                }
            }

            stringRegex?.enumerateMatches(in: textView.string, options: [], range: range) { match, _, _ in
                if let matchRange = match?.range {
                    attributedString.addAttribute(.foregroundColor, value: NSColor.systemGreen, range: matchRange)
                }
            }

            numberRegex?.enumerateMatches(in: textView.string, options: [], range: range) { match, _, _ in
                if let matchRange = match?.range {
                    attributedString.addAttribute(.foregroundColor, value: NSColor.systemOrange, range: matchRange)
                }
            }

            commentRegex?.enumerateMatches(in: textView.string, options: [], range: range) { match, _, _ in
                if let matchRange = match?.range {
                    attributedString.addAttribute(.foregroundColor, value: NSColor.systemGray, range: matchRange)
                }
            }
            
            booleanRegex?.enumerateMatches(in: textView.string, options: [], range: range) { match, _, _ in
                if let matchRange = match?.range {
                    attributedString.addAttribute(.foregroundColor, value: NSColor.systemTeal, range: matchRange)
                }
            }

            let selectedRange = textView.selectedRange()
            textView.textStorage?.beginEditing()
            textView.textStorage?.setAttributedString(attributedString)
            textView.textStorage?.endEditing()
            textView.setSelectedRange(selectedRange)
        }
    }
}
