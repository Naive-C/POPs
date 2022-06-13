//
//  HomeView.swift
//  POPs
//
//  Created by Naive-C on 2022/04/06.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    @Binding var ShowLeftSideMenu: Bool
    @Binding var ShowRightSideMenu: Bool
    
    @State private var inputText: String = ""
    
    let user: UserModel
    
    init(user: UserModel, ShowLeftSideMenu: Binding<Bool>, ShowRightSideMenu: Binding<Bool>) {
        self.user = user
        self._ShowLeftSideMenu = ShowLeftSideMenu
        self._ShowRightSideMenu = ShowRightSideMenu
        AuthViewModel.shared.fetchUser()
    }
    
    var body: some View {
        NavigationView{
            VStack{
                SlideScreen(user: user)
                    .background(Color(.systemGray6))
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.ShowLeftSideMenu.toggle()
                    }, label: {
                        Image("setting")
                        
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        self.ShowRightSideMenu.toggle()
                    }, label: {
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                    })
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SlideScreen: View {
    @ObservedObject var feedVM = PostViewModel()
    @ObservedObject var newsVM = NewsAPI()
    
    @State private var index: Int = 0
    @State private var offset:CGFloat = getRect().width / 2
    
    var width: CGFloat = getRect().width
    
    let user: UserModel
    
    var body: some View {
        VStack {
            SlideMenu(index: $index, offset: $offset)
                .background(Color.white)
            
            HStack(spacing: 0) {
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(newsVM.articles, id:\.title) { article in
                            NewsPostCell(article: article)
                                .background(Color.white)
                        }
                    }
                }
                .frame(width: getRect().width)
                
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(feedVM.sortedPosts) { post in
                            HomePostCell(feedVM: PostCellViewModel(post: post, user: user))
                                .background(Color.white)
                        }
                    }
                }
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

struct SlideMenu: View {
    @Binding var index: Int
    @Binding var offset: CGFloat
    var width: CGFloat = UIScreen.main.bounds.width
    
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
                    
                    Text("News")
                        .foregroundColor(self.index == 0 ? .black : Color.gray.opacity(1))
                        .font(.system(size: 14, weight: .semibold))
                        .frame(maxWidth: .infinity)
                    
                    
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
                    
                    Text("Home")
                        .foregroundColor(self.index == 1 ? .black : Color.gray.opacity(1))
                        .font(.system(size: 14, weight: .semibold))
                        .frame(maxWidth: .infinity)
                    
                    
                    Capsule()
                        .fill(self.index == 1 ? Color.blue : Color.clear)
                        .frame(width: 60, height: 2)
                }
            })
        }
        .frame(width: getRect().width)
        .frame(maxHeight: 50)
        .padding(.top, 10)
    }
}

struct ScrollRefreshable<Content: View>: View {
    
    var content: Content
    var onRefresh: () async ->()
    
    init(title: String,tintColor: Color,@ViewBuilder content: @escaping ()->Content,onRefresh: @escaping () async ->()){
        
        self.content = content()
        self.onRefresh = onRefresh
        
        // Modifying Refresh Control...
        UIRefreshControl.appearance().attributedTitle = NSAttributedString(string: title)
        UIRefreshControl.appearance().tintColor = UIColor(tintColor)
    }
    
    var body: some View {
        
        List{
            // Preview Bug....
            content
                .listRowSeparatorTint(.clear)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
        .refreshable {
            await onRefresh()
        }
    }
}
