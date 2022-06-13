//
//  FollwersListView.swift
//  POPs
//
//  Created by Naive-C on 2022/06/04.
//

import SwiftUI

struct FollowersListView: View {
    @Environment(\.presentationMode) var mode
    
    @ObservedObject var followersVM: FollowersViewModel
    
    @State var rightSide: Bool = false
    @State var isActive: Bool = false
    
    let user: UserModel
    
    init(user: UserModel) {
        self.user = user
        followersVM = FollowersViewModel(user: user)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(followersVM.users) { follower in
                    NavigationLink(destination: UserProfileView(user: follower, rightSide: $rightSide, isActive: $isActive), label: {
                        UserCell(user: follower)
                            .foregroundColor(.black)
                    })
                }
            }
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden(true)
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

