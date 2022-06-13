//
//  TextArea.swift
//  POPs
//
//  Created by Naive-C on 2022/04/29.
//

import SwiftUI

struct TextArea: View {
    @Binding var text: String
    let placeholder: String
    
    // MARK: - TextEditor Placeholder Ref https://lostmoa.com/blog/AddPlaceholderTextToSwiftUITextEditor/
    init(text: Binding<String>, placeholder: String) {
        self._text = text
        self.placeholder = placeholder
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.black.opacity(0.4))
                    .padding(.horizontal, 5)
                    .padding(.vertical, 10)
            }
            TextEditor(text: $text)
        }
        .font(.body)
    }
}
