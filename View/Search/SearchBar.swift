//
//  SearchBar.swift
//  POPs
//
//  Created by Naive-C on 2022/04/12.
//

import SwiftUI

struct SearchBar: View {
    @Binding var inputText: String
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack{
            TextField("Search...", text: $inputText)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
                .onTapGesture {
                    isEditing = true
                }
            
            if isEditing {
                Button(action: {
                    inputText = ""
                    isEditing = false
                }, label: {
                    Text("Cancel")
                })
            }
        }
    }
}

struct SearchBar_PreView: PreviewProvider {
    static var previews: some View {
        SearchBar(inputText: .constant(""), isEditing: .constant(false))
    }
}
