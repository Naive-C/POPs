//
//  ShortTypeView.swift
//  POPs
//
//  Created by Naive-C on 2022/06/04.
//

import Foundation
import SwiftUI
import Kingfisher

struct ShortTypeGridView: View {
    @Environment(\.presentationMode) var mode
    
    @ObservedObject var typeVM = ShortViewModel()
    
    let user: UserModel
    let type: String
    
    let gridLayout:[GridItem] = Array(repeating: .init(.flexible(), spacing: 2), count: 2)
    
    init(user: UserModel, type: String) {
        self.user = user
        self.type = type
        typeVM.fetchTypeShort(type: type)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridLayout, spacing: 2) {
                ForEach(typeVM.posts) { post in
                    ShortCellView(user: user, post: post)
                }
            }
        }
        .padding([.horizontal, .vertical])
        .navigationTitle(type)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    mode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.black)
                })
            }
        }
    }
}
