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
    @State private var isFormatting = false

    init(themeManager: ThemeManager) {
        let viewModel = CodeEditorViewModel(themeManager: themeManager)
        _viewModel = StateObject(wrappedValue: viewModel)
        self.themeManager = themeManager
    }

    var body: some View {
        VStack(spacing: 0) {
            CustomToolbar(themeManager: themeManager, viewModel: viewModel, isFormatting: $isFormatting)
                .frame(maxWidth: .infinity, maxHeight: 40)
                .padding(.horizontal)
                .background(Color(NSColor.windowBackgroundColor))
                .overlay(Divider(), alignment: .top)
                .overlay(Divider(), alignment: .bottom)
            
            HStack(spacing: 1) {
                CodeInputView(viewModel: viewModel, themeManager: themeManager)
                CodeOutputView(viewModel: viewModel, themeManager: themeManager)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .automatic) {
                Text("DevLint - Swift Code Formatter")
                    .font(themeManager.currentTheme.font)
                Spacer()
                Button {
                    NSApp.orderFrontStandardAboutPanel()
                } label: {
                    Image(systemName: "info.circle")
                }
                .help("info")
            }
        }
    }
}
