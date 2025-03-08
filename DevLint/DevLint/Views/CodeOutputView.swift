//
//  CodeOutputView.swift
//  DevLint
//
//  Created by CS Prasad on 09/03/25.
//

import SwiftUI

struct CodeOutputView: View {
    @ObservedObject var viewModel: CodeEditorViewModel
    let themeManager: ThemeManager

    var body: some View {
        EditorSectionView(
            title: "Formatted Output",
            text: $viewModel.formattedCode,
            buttonTitle: "Copy Code",
            buttonAction: { viewModel.copyToClipboard() },
            isButtonDisabled: viewModel.formattedCode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            isEditable: false,
            themeManager: themeManager,
            lineNumbers: $viewModel.lineNumbers // ❗️ You might need a separate list for output line numbers
        )
    }
}
