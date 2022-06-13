//
//  ShortCellView.swift
//  POPs
//
//  Created by Naive-C on 2022/06/08.
//

import SwiftUI
import Kingfisher

struct ShortCellView: View {
    @ObservedObject var shortCellVM: ShortCellViewModel
    
    let user: UserModel
    let post: PostModel
    
    init(user: UserModel, post: PostModel) {
        self.user = user
        self.post = post
        shortCellVM = ShortCellViewModel(user: user, post: post)
    }
    
    var body: some View {
        VStack {
            NavigationLink(destination: PostDetail(feedVM: PostCellViewModel(post: post, user: shortCellVM.user)), label: {
                ZStack {
                    KFImage(URL(string: post.imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: getRect().width / 2 - 30, height: 180)
                        .clipShape(Rectangle())
                        .cornerRadius(10)
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(LinearGradient(gradient: Gradient(colors: [.black, .black.opacity(0.1)]), startPoint: .top, endPoint: .bottom))
                        .frame(width: getRect().width / 2 - 30, height: 30)
                        .frame(maxHeight: .infinity, alignment: .top)
                        .cornerRadius(10)
                    Text(post.ownerUsername)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                }
            })
            .padding(.bottom)
        }
    }
}
