//
//  ContentView.swift
//  DevLint
//
//  Created by CS Prasad on 23/02/25.
//

import SwiftUI

struct ContentView: View {
    @State private var inputCode: String = ""
    @State private var formattedCode: String = ""

    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue, Color.green]), startPoint: .topLeading,endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("DevLint - Swift Code Formatter")
                    .font(.title)
                    .padding()
                
                HStack {
                    VStack(alignment: .center) {
                        Text("Input Code")
                            .font(.headline)
                        
                        VStack {
                            HStack(alignment: .top, spacing: 0) {
                                LineNumberView(text: inputCode)
                                CodeEditor(text: $inputCode)
                                    .frame(minWidth: 300, minHeight: 400)
                                    .padding(.leading, 5)
                            }
                            .background(Color(NSColor.textBackgroundColor))
                            .cornerRadius(5)
                        }
                        
                        Button(action: formatSwiftCode) {
                            Label("Format Code", systemImage: "wand.and.stars")
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.blue.opacity(0.2))
                        .controlSize(.large)
                    }
                    
                    VStack(alignment: .center) {
                        Text("Formatted Output")
                            .font(.headline)
                        
                        VStack {
                            HStack(alignment: .top, spacing: 0) {
                                LineNumberView(text: formattedCode)
                                CodeEditor(text: $formattedCode)
                                    .frame(minWidth: 300, minHeight: 400)
                                    .padding(.leading, 5)
                            }
                            .background(Color(NSColor.textBackgroundColor))
                            .cornerRadius(5)
                        }.disabled(true)
                        
                        Button(action: copyToClipboard) {
                            Label("Copy Code", systemImage: "doc.on.doc")
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.green.opacity(0.2))
                        .controlSize(.large)
                        
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }
        
    func formatSwiftCode() {
        let tempFile = "/tmp/temp.swift"
        let outputFile = "/tmp/formatted.swift"
        
        do {
            try inputCode.write(toFile: tempFile, atomically: true, encoding: .utf8)
            let process = Process()
            process.launchPath = "/usr/local/bin/swiftformat"
            process.arguments = [tempFile, "--output", outputFile]
            
            try process.run()
            process.waitUntilExit()
            
            formattedCode = try String(contentsOfFile: outputFile, encoding: .utf8)
        } catch {
            formattedCode = "Error formatting code."
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
