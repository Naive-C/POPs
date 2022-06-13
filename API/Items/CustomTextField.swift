//
//  CustomTextField.swift
//  POPs
//
//  Created by Naive-C on 2022/04/14.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    let placeholder: Text
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .foregroundColor(.black.opacity(0.5))
                    .padding(.horizontal, 4)
            }
            
            VStack {
                TextField("", text: $text)
                    .padding(.horizontal, 4)
            }
        }
    }
}

struct SocialTextField: View {
    @Binding var text: String
    let placeholder: Text
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .foregroundColor(.black.opacity(0.5))
                    .padding(.horizontal, 4)
            }
            
            VStack {
                TextField("", text: $text)
                    .padding(.horizontal, 4)
            }
        }
    }
}


struct TitleTextField: View {
    @Binding var text: String
    let placeholder: Text
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black.opacity(0.5))
                    .padding(.horizontal, 4)
            }
            
            VStack {
                TextField("", text: $text)
                    .font(.system(size: 18, weight: .bold))
                    .padding(.horizontal, 4)
            }
        }
    }
}
