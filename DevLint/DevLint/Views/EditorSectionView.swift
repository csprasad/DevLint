//
//  EditorSectionView.swift
//  DevLint
//
//  Created by CS Prasad on 09/03/25.
//

import Foundation

import SwiftUI

struct EditorSectionView: View {
    @Binding var text: String
    let isEditable: Bool
    let themeManager: ThemeManager
    @Binding var lineNumbers: [Int]

    var body: some View {
        VStack {
            ScrollView {
                HStack(spacing: .zero) {
                    // Line numbers
                    LineNumbersView(lineNumbers: $lineNumbers, themeManager: themeManager)
                        .padding(.zero)
                    
                    // Code Editor
                    CodeEditorView(text: $text, themeManager: themeManager)
                        .font(themeManager.currentTheme.font)
                        .padding(.zero)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .disabled(!isEditable)
                }
                .padding(.zero)
            }
        }
    }
}
