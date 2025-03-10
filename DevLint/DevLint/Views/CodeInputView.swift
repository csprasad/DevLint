//
//  CodeInputView.swift
//  DevLint
//
//  Created by CS Prasad on 09/03/25.
//

import SwiftUI

struct CodeInputView: View {
    @ObservedObject var viewModel: CodeEditorViewModel
    let themeManager: ThemeManager

    var body: some View {
        EditorSectionView(
            text: $viewModel.inputCode,
            isEditable: true,
            themeManager: themeManager,
            lineNumbers: $viewModel.lineNumbers
        )
        .onChange(of: viewModel.inputCode) { _ in
            viewModel.updateLineNumbers()
        }
    }
}
