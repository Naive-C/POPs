//
//  NotificationCell.swift
//  POPs
//
//  Created by Naive-C on 2022/04/07.
//

import SwiftUI
import Kingfisher

struct NotificationCell: View {
    @ObservedObject var viewModel: NotificationCellViewModel
    
    @State var rightSide: Bool = false
    @State var isActive: Bool = false
    
    var isFollowed: Bool { return viewModel.notification.isFollowed ?? false }
    
    let user: UserModel
    
    init(user: UserModel, viewModel: NotificationCellViewModel) {
        self.user = user
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            if let user = viewModel.notification.user {
                NavigationLink(
                    destination: UserProfileView(user: user, rightSide: $rightSide, isActive: $isActive)
                        .navigationBarBackButtonHidden(true)
                    , label: {
                        KFImage(URL(string: viewModel.notification.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        VStack {
                            Text(viewModel.notification.username).font(.system(size: 12, weight: .semibold)) +
                            Text(viewModel.notification.type.notificationMessage)
                                .font(.system(size:12))
                        }
                    })
                .foregroundColor(.black)
            }
            Spacer()
            
            if viewModel.notification.type != .follow {
                if let post = viewModel.notification.post {
                    NavigationLink(destination: PostDetail(feedVM: PostCellViewModel(post: post, user: user)), label: {
                        KFImage(URL(string: post.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                    })
                }
            } else {
                Button(action: {
                    isFollowed ? viewModel.unfollow() : viewModel.follow()
                }, label: {
                    Text(isFollowed ? "Following" : "Follow")
                        .font(.system(size: 14, weight: .semibold))
                        .frame(width: 80, height: 32)
                        .foregroundColor(isFollowed ? .black : .white)
                        .background(isFollowed ? Color.white : Color.blue)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(Color.gray, lineWidth: isFollowed ? 1 : 0)
                        )
                })
            }
        }
    }
}
