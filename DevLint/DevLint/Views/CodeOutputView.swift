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
            text: $viewModel.formattedCode,
            isEditable: false,
            themeManager: themeManager,
            lineNumbers: $viewModel.lineNumbers // ❗️ You might need a separate list for output line numbers
        )
    }
}
