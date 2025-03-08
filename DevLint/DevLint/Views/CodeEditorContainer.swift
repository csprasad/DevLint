//
//  CodeEditorView.swift
//  DevLint
//
//  Created by CS Prasad on 03/03/25.
//

import SwiftUI

struct CodeEditorContainer: View {
    @StateObject private var viewModel: CodeEditorViewModel
    @ObservedObject private var themeManager: ThemeManager

    init(themeManager: ThemeManager) {
        let viewModel = CodeEditorViewModel(themeManager: themeManager)
        _viewModel = StateObject(wrappedValue: viewModel)
        self.themeManager = themeManager
    }

    var body: some View {
        VStack {
            ThemeSelectorView(themeManager: themeManager)
            HStack {
                CodeInputView(viewModel: viewModel, themeManager: themeManager)
                CodeOutputView(viewModel: viewModel, themeManager: themeManager)
            }
        }
    }
}
