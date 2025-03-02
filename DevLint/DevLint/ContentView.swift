//
//  ContentView.swift
//  DevLint
//
//  Created by CS Prasad on 23/02/25.
//

import SwiftFormat
import SwiftUI

struct ContentView: View {
    @State private var inputCode: String = ""
    @State private var formattedCode: String = ""

                                    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.purple,
                    Color.blue,
                    Color.green,
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)

                                    VStack(spacing: 10) {
                // Title
                Text("DevLint - Swift Code Formatter")
                    .font(.largeTitle)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)

                // Editor Section
                HStack(spacing: 10) {
                    // Input Editor
                    VStack(spacing: 5) {
                        Text("Input Code")
                            .font(.headline)
                            .frame(height: 30)

                        HStack(alignment: .top) {
                            LineNumberView(text: inputCode)
                            CodeEditor(text: $inputCode)
//                                .frame(maxWidth: .infinity, minHeight: 300)
//                                .padding(.leading, 5)
                        }
                        .background(Color(NSColor.textBackgroundColor))
                        .cornerRadius(5)

                        Button(action: formatSwiftCode) {
                            Label("Format Code", systemImage: "wand.and.stars")
                        }
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.borderedProminent)
                        .tint(Color.blue.opacity(0.2))
                        .controlSize(.large)
                    }

                    // Formatted Output
                    VStack(spacing: 5) {
                        Text("Formatted Output")
                            .font(.headline)
                            .frame(height: 30)

                        HStack(alignment: .top) {
                            LineNumberView(text: formattedCode)
                            CodeEditor(text: $formattedCode)
//                                .frame(maxWidth: .infinity, minHeight: 300)
//                                .padding(.leading, 5)
                        }
                        .background(Color(NSColor.textBackgroundColor))
                        .cornerRadius(5)
                        .disabled(true)

                        Button(action: copyToClipboard) {
                            Label("Copy Code", systemImage: "doc.on.doc")
                        }
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.borderedProminent)
                        .tint(Color.green.opacity(0.2))
                        .controlSize(.large)
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.vertical, 10)
//            .buttonStyle(.borderedProminent)
        }
    }

    func formatSwiftCode() {
        do {
            let source = try SwiftFormat.format(inputCode)
            formattedCode = source.output
        } catch {
            print("Formatting error: \(error)")
            formattedCode = error.localizedDescription
        }
    }

    func copyToClipboard() {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(formattedCode, forType: .string)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
