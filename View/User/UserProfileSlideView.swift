//
//  UserSlideMenu.swift
//  POPs
//
//  Created by Naive-C on 2022/04/27.
//

import SwiftUI
import Foundation

struct UserProflieSlideScreen:View {
    @ObservedObject var userVM : UserSlideMenuViewModel
    @ObservedObject var postVM = PostViewModel()
    
    @State var text: String = ""
    @State private var index: Int = 0
    @State private var offset:CGFloat = getRect().width / 2
    @State var name: String = "test"
    
    var width: CGFloat = getRect().width
    
    let user: UserModel
    
    init(user: UserModel) {
        self.user = user
        userVM = UserSlideMenuViewModel(user: user)
        postVM.allPost()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            UserProfileSlideMenu(index: $index, offset: $offset)
            
            HStack(spacing: 0) {
                // MARK: - ListView 생성
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(userVM.posts) { post in
                            HomePostCell(feedVM: PostCellViewModel(post: post, user: userVM.user))
                        }
                    }
                    .frame(width: getRect().width)
                }
                VStack(alignment: .leading) {
                    Divider()
                    Text("Description")
                        .font(.system(size: 14, weight: .bold))
                    if let description = userVM.user.description {
                        Text(description)
                    }
                    
                    Capsule()
                        .frame(height: 2)
                        .foregroundColor(Color(.systemGray6))
                    
                    HStack {
                        Image("Instagram-Icon")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 15, height: 15)
                        if let socialLink = userVM.user.socialLink, let socialName = userVM.user.socialName {
                            Link(destination: URL(string: "https://www.instagram.com/accounts/login/?next=/\(socialName)/")! , label: {
                                Text(socialName)
                                    .font(.system(size: 14, weight: .regular))
                            })
                        }
                    }
                    .padding(.vertical, 5)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .frame(width: getRect().width)
            }
            .offset(x: offset)
            .highPriorityGesture(DragGesture()
                .onEnded({ (value) in
                    if value.translation.width > 50 {
                        withAnimation {
                            self.changeView(left: false)
                        }
                    }
                    if -value.translation.width > 50 {
                        withAnimation {
                            self.changeView(left: true)
                        }
                    }
                })
            )
        }
    }
    func changeView(left: Bool) {
        if left {
            if self.index != 1 {
                self.index += 1
            }
        }
        else {
            if self.index != 0 {
                self.index -= 1
            }
        }
        if self.index == 0 {
            self.offset = self.width / 2
        }
        else if self.index == 1 {
            self.offset = -self.width / 2
        }
    }
}

struct UserProfileSlideMenu: View {
    @Binding var index: Int
    @Binding var offset: CGFloat
    
    var width = getRect().width
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation {
                    self.index = 0
                    self.offset = self.width / 2
                }
            }, label: {
                VStack {
                    Spacer()
                    Text("Posts")
                        .foregroundColor(self.index == 0 ? .black : Color.gray.opacity(1))
                        .font(.system(size: 14, weight: .semibold))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    Capsule()
                        .fill(self.index == 0 ? Color.blue : Color.clear)
                        .frame(width: 60, height: 2)
                }
            })
            
            Button(action: {
                withAnimation {
                    self.index = 1
                    self.offset = -self.width / 2
                }
            }, label: {
                VStack {
                    Spacer()
                    Text("About")
                        .foregroundColor(self.index == 1 ? .black : Color.gray.opacity(1))
                        .font(.system(size: 14, weight: .semibold))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    Capsule()
                        .fill(self.index == 1 ? Color.blue : Color.clear)
                        .frame(width: 60, height: 2)
                }
            })
        }
        .frame(maxWidth: .infinity, maxHeight: 30)
    }
}
