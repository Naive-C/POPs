//
//  CustomInputView.swift
//  POPs
//
//  Created by Naive-C on 2022/04/30.
//

import SwiftUI

struct CustomInputView: View {
    @Binding var text: String
    
    var action: () -> Void 
        
    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color(.separator))
                .frame(width: getRect().width, height: 0.75)
                .padding(.bottom, 8)
            
            HStack {
                TextField("Add a Comment", text: $text)
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(minHeight: 30)
                
                Button(action: {
                    action()
                }, label: {
                    Text("Send")
                        .bold()
                        .foregroundColor(.black)
                })
            }
        .padding(.horizontal)
        }
    }
}
