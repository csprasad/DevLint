//
//  ContentView.swift
//  DevLint
//
//  Created by CS Prasad on 23/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var themeManager = ThemeManager()

    var body: some View {
        CodeEditorView(themeManager: themeManager)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
