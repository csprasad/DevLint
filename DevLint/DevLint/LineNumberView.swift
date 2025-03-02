//
//  LineNumberView.swift
//  DevLint
//
//  Created by CS Prasad on 23/02/25.
//

import SwiftUI

struct LineNumberView: View {
    let text: String

    private var lineNumbers: [String] {
        let lines = text.components(separatedBy: "\n").count
        return (1 ... lines).map { "\($0)" }
    }

    var body: some View {
        VStack(alignment: .trailing) {
            ForEach(lineNumbers, id: \..self) { number in
                Text(number)
                    .font(.system(.body, design: .monospaced))
                    .foregroundColor(.gray)
                    .frame(width: lineNumberWidth(), alignment: .trailing)
            }
        }
        .padding(.trailing, 5)
    }

    private func lineNumberWidth() -> CGFloat {
        let maxDigits = String(lineNumbers.count).count
        return CGFloat(maxDigits * 10) // Adjust width based on digit count
    }
}
