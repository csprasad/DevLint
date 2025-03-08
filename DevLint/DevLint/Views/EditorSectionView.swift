//
//  EditorSectionView.swift
//  DevLint
//
//  Created by CS Prasad on 09/03/25.
//

import Foundation

import SwiftUI

struct EditorSectionView: View {
    let title: String
    @Binding var text: String
    let buttonTitle: String
    let buttonAction: () -> Void
    let isButtonDisabled: Bool
    let isEditable: Bool
    let themeManager: ThemeManager
    @Binding var lineNumbers: [Int]

    var body: some View {
        VStack {
            Text(title).font(.headline)
            
            ScrollView {
                HStack(spacing: .zero) {
                    // Line numbers
                    LineNumbersView(lineNumbers: $lineNumbers, themeManager: themeManager)
//                        .foregroundColor(Color(themeManager.currentTheme.secondaryColor))
                        .padding(.zero)
                    
                    // Code Editor
                    CodeEditorView(text: $text, themeManager: themeManager)
                        .font(themeManager.currentTheme.font)
                        .padding(.zero)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .background(.red)//Color(themeManager.currentTheme.backgroundColor))
                        .disabled(!isEditable)
                }
                .padding(.zero)
            }
            Button(action: buttonAction) {
                Label(buttonTitle, systemImage: isEditable ? "wand.and.stars" : "doc.on.doc")
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .buttonStyle(.borderedProminent)
            .tint(isEditable ? Color.blue.opacity(0.2) : Color.green.opacity(0.2))
            .controlSize(.large)
            .disabled(isButtonDisabled)
        }
    }
}
