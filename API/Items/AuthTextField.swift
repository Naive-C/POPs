//
//  AuthButton.swift
//  POPs
//
//  Created by Naive-C on 2022/04/24.
//

import Foundation
import SwiftUI

struct AuthTextField: View {
    @Binding var text: String
    let placeholder: Text
    let imageName: String
    
    var body : some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .foregroundColor(Color(.init(white: 0.1, alpha: 0.8)))
                    .padding(.leading, 30)
            }
            
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                TextField("", text: $text)
            }
        }
    }
}

struct AuthTextField_Preview : PreviewProvider {
    static var previews: some View {
        AuthTextField(text: .constant(""), placeholder: Text("Email"), imageName: "applelogo")
    }
}
