//
//  NotificationView.swift
//  POPs
//
//  Created by Naive-C on 2022/04/06.
//

import SwiftUI
import Kingfisher

struct NotificationView: View {
    @ObservedObject var notiVM = NotificationViewModel()
    
    @Binding var ShowLeftSideMenu: Bool
    @Binding var ShowRightSideMenu: Bool
    
    let sideBarWidth = getRect().width - 90
    
    let user: UserModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(notiVM.notifications) { notification in
                        NotificationCell(user: user, viewModel: NotificationCellViewModel(notification: notification))
                            .padding([.horizontal, .top], 15)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Inbox")
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
        }
    }
}
//        NavigationView {
//            VStack {
//                ScrollView {
//                    LazyVStack {
//                        ForEach(notiVM.notifications) { notification in
//                            NotificationCell(notification: notification)
//                                .padding([.horizontal, .top], 15)
//                        }
//                    }
//                }
//            }
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationTitle("Inbox")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading){
//                    Button(action: {
//                        self.ShowLeftSideMenu.toggle()
//                    }, label: {
//                        Image("setting")
//                    })
//                }
//                ToolbarItem(placement: .navigationBarTrailing){
//                    Button(action: {
//                        self.ShowRightSideMenu.toggle()
//                    }, label: {
//                        Image("user")
//                    })
//                }
//            }
//        }
