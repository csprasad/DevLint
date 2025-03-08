//
//  CodeEditorView.swift
//  DevLint
//
//  Created by CS Prasad on 03/03/25.
//

import SwiftUI

struct CodeEditorView: View {
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
                VStack {
                    Text("Input Code").font(.headline)
                    ScrollView {
                        HStack(alignment: .top, spacing: 0) {
                            // Line numbers column
                            LineNumbersView(lineNumbers: $viewModel.lineNumbers, themeManager: themeManager)
                                .foregroundColor(Color(themeManager.currentTheme.secondaryColor))
                                .padding([.top,.bottom])

                            // Code editor
                            CustomTextEditor(text: $viewModel.inputCode, themeManager: themeManager)
                                .font(themeManager.currentTheme.font)
                                .padding([.top,.bottom])
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .background(Color(themeManager.currentTheme.backgroundColor))
                        }
                        .padding()
                    }
                    .onChange(of: viewModel.inputCode) { _ in
                        print("onChange triggered in ContentView. New value: format")
                        viewModel.updateLineNumbers()
                    }

                    Button(action: {
                        viewModel.formatSwiftCode()
                    }) {
                        Label("Format Code", systemImage: "wand.and.stars")
                    }
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.borderedProminent)
                    .tint(Color.blue.opacity(0.2))
                    .controlSize(.large)
                    .disabled(viewModel.inputCode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }

                VStack {
                    Text("Formatted Output").font(.headline)

                    ScrollView {
                        HStack(alignment: .top, spacing: 0) {
                            // Line numbers column
                            LineNumbersView(lineNumbers: $viewModel.lineNumbers, themeManager: themeManager)
                                .foregroundColor(Color(themeManager.currentTheme.secondaryColor))
                                .padding([.top,.bottom])

                            // Code editor
                            CustomTextEditor(text: $viewModel.formattedCode, themeManager: themeManager)
                                .font(themeManager.currentTheme.font)
                                .padding([.top,.bottom])
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .background(Color(themeManager.currentTheme.backgroundColor))
                        }
                        .padding()
                        .disabled(true)
                    }

                    Button(action: {
                        viewModel.copyToClipboard()
                    }) {
                        Label("Copy Code", systemImage: "doc.on.doc")
                    }
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.borderedProminent)
                    .tint(Color.green.opacity(0.2))
                    .controlSize(.large)
                    .disabled(viewModel.formattedCode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) // ❌ Only disable if output is empty
                }
            }
        }
    }
}

// Line numbers view
struct LineNumbersView: View {
    @Binding var lineNumbers: [Int]
    @ObservedObject var themeManager: ThemeManager

    var body: some View {
        VStack(alignment: .trailing, spacing: 4) {
            ForEach(lineNumbers, id: \.self) { number in
                Text("\(number)")
                    .font(themeManager.currentTheme.font)
                    .foregroundColor(.gray)
                    .padding(.trailing, 8)
            }
        }
        .frame(width: 40)
    }
}

extension Color {
    /// Create a SwiftUI Color from a hex string.
    init(hex: String) {
        self.init(nsColor: NSColor(hex: hex))
    }
}
