//
//  ShortGridView.swift
//  POPs
//
//  Created by Naive-C on 2022/04/09.
//

import SwiftUI
import Kingfisher

struct ShortGridView: View {
    @ObservedObject var shortVM = ShortViewModel()
    
    let user: UserModel
    
    init(user: UserModel) {
        self.user = user
        shortVM.fetchAllShort()
    }
    
    let gridLayout:[GridItem] = Array(repeating: .init(.flexible(), spacing: 2), count: 2)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridLayout, spacing: 2) {
                ForEach(shortVM.sortedPosts) { post in
                    ShortCellView(user: user, post: post)
                }
            }
        }
        .padding([.horizontal, .vertical])
    }
}
