//
//  LineNumberView.swift
//  DevLint
//
//  Created by CS Prasad on 09/03/25.
//

import SwiftUI

struct LineNumbersView: View {
    @Binding var lineNumbers: [Int]
    @ObservedObject var themeManager: ThemeManager

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(lineNumbers, id: \.self) { number in
                Text("\(number)")
                    .font(themeManager.currentTheme.font)
                    .foregroundColor(.gray)
                    .padding(.leading)
            }
        }
        .background(Color(themeManager.currentTheme.backgroundColor))
    }
}
