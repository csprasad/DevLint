//
//  ToolbarButton.swift
//  DevLint
//
//  Created by CS Prasad on 10/03/25.
//

import SwiftUI

struct ToolbarButton: View {
    var icon: String?
    var text: String?
    var tooltip: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            if let icon = icon {
                Image(systemName: icon)
            } else if let text = text {
                Text(text)
            }
        }
        .help(tooltip)
    }
}
