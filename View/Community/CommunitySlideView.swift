//
//  CommunitySlideView.swift
//  POPs
//
//  Created by Naive-C on 2022/05/10.
//

import SwiftUI

struct CommunitySlideView: View {
    @ObservedObject var commuVM: CommunitySlideMenuViewModel
    
    @State var text: String = ""
    @State private var index: Int = 0
    @State private var offset:CGFloat = getRect().width / 2
    
    @State var rightSide: Bool = false
    @State var isActive: Bool = false
    
    var width: CGFloat = getRect().width
   
    var body: some View {
        VStack(spacing: 0) {
            CommunityProfileSlideMenu(index: $index, offset: $offset)
            HStack(spacing: 0) {
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(commuVM.posts) { post in
                            HomePostCell(feedVM: PostCellViewModel(post: post, user: commuVM.user))
                        }
                    }
                    .frame(width: getRect().width)
                }
                VStack(alignment: .leading) {
                    Divider()
                    Text("Moderators")
                        .font(.system(size: 14, weight: .bold))
                    Capsule()
                        .frame(height: 3)
                        .foregroundColor(Color(.systemGray6))
                    
                    NavigationLink(destination: UserProfileView(user: commuVM.user, rightSide: $rightSide, isActive: $isActive), label: {
                        Text(commuVM.user.username)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.black)
                            .padding(.top)
                    })
                    Spacer()
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
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

struct CommunityProfileSlideMenu: View {
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
                VStack{
                    Spacer()
                    Text("Posts")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(self.index == 0 ? .black : Color.gray.opacity(1))
                    
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
                VStack{
                    Spacer()
                    Text("About")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(self.index == 1 ? .black : Color.gray.opacity(1))
                    
                    Capsule()
                        .fill(self.index == 1 ? Color.blue : Color.clear)
                        .frame(width: 60, height: 2)
                }
            })
        }
        .frame(maxHeight: 32)
        .frame(width: getRect().width)
        .padding(.top, 10)
    }
}
