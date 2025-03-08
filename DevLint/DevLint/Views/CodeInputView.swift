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
            title: "Input Code",
            text: $viewModel.inputCode,
            buttonTitle: "Format Code",
            buttonAction: { viewModel.formatSwiftCode() },
            isButtonDisabled: viewModel.inputCode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            isEditable: true,
            themeManager: themeManager,
            lineNumbers: $viewModel.lineNumbers
        )
        .onChange(of: viewModel.inputCode) { _ in
            viewModel.updateLineNumbers()
        }
    }
}
