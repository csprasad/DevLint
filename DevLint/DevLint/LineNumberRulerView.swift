//
//  LineNumberRulerView.swift
//  DevLint
//
//  Created by CS Prasad on 23/02/25.
//

import AppKit

class LineNumberRulerView: NSRulerView {
    weak var textView: NSTextView?

    init(textView: NSTextView) {
        self.textView = textView
        super.init(scrollView: textView.enclosingScrollView, orientation: .verticalRuler)
        self.clientView = textView
        self.ruleThickness = 20 // Width of ruler
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawHashMarksAndLabels(in rect: NSRect) {
        guard let textView = textView, let layoutManager = textView.layoutManager else { return }
        
        let text = textView.string as NSString
        let totalLines = text.components(separatedBy: "\n").count

        let numberAttributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.monospacedSystemFont(ofSize: 12, weight: .regular),
            .foregroundColor: NSColor.secondaryLabelColor
        ]

        let lineHeight = layoutManager.defaultLineHeight(for: textView.font ?? NSFont.systemFont(ofSize: 12))
        var yPos = textView.textContainerInset.height + 5

        for i in 1...totalLines {
            let lineNumber = "\(i)" as NSString
            let lineRect = NSRect(x: 5, y: yPos, width: self.bounds.width - 10, height: 12)
            lineNumber.draw(in: lineRect, withAttributes: numberAttributes)
            yPos += lineHeight
        }
    }
}
