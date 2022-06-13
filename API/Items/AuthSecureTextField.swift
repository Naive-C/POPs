//
//  AuthSecureTextField.swift
//  POPs
//
//  Created by Naive-C on 2022/04/24.
//

import Foundation
import SwiftUI

struct AuthSecureTextField: View {
    @Binding var text: String
    let placeholder: Text
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .foregroundColor(Color(.init(white: 0.1, alpha: 0.8)))
                    .padding(.leading, 30)
            }
            
            HStack {
                Image(systemName: "lock")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                SecureField("", text: $text)
            }
        }
    }
}
