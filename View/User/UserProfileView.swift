//
//  UserProfileView.swift
//  POPs
//
//  Created by Naive-C on 2022/04/25.
//

import SwiftUI
import Kingfisher

struct UserProfileView: View {
    @Environment(\.presentationMode) var mode
    
    @ObservedObject var userProfileVM: UserProfileViewModel
    @ObservedObject var stateVM: UserStateViewModel
    
    let user : UserModel
    
    @Binding var rightSide: Bool
    @Binding var isActive: Bool
    
    init(user: UserModel, rightSide: Binding<Bool>, isActive: Binding<Bool>) {
        self.user = user
        self._rightSide = rightSide
        self._isActive = isActive
        self.userProfileVM = UserProfileViewModel(user: user)
        self.stateVM = UserStateViewModel(user: user)
    }
    
    var body: some View {
        VStack {
            UserProfileHeaderView(userProfileVM: userProfileVM, stateVM: stateVM, rightSide: $rightSide, isActive: $isActive, user: user)
            UserProflieSlideScreen(user: userProfileVM.user)
            Spacer()
        }
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

struct UserProfileHeaderView: View {
    @ObservedObject var userProfileVM: UserProfileViewModel
    @ObservedObject var stateVM: UserStateViewModel
    
    @Binding var rightSide: Bool
    @Binding var isActive: Bool
    
    let user: UserModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                KFImage(URL(string: userProfileVM.user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                Spacer()
                userProfileBtnView(userProfileVM: userProfileVM, rightSide: $rightSide, isActive: $isActive, user: user)
            }
            VStack(alignment: .leading) {
                Text(userProfileVM.user.username)
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .bold))
                if userProfileVM.user.isCurrentUser {
                    NavigationLink(destination: FollowersListView(user: user), label: {
                        HStack {
                            if let state = stateVM.user.state {
                                Text("\(state.followers) followers")
                                Image(systemName: "chevron.right")
                                    .frame(width: 8, height: 8)
                            }
                        }
                        .foregroundColor(.black)
                        .padding(.top, 8)
                        .padding(.bottom, 2)
                        .font(.system(size: 14, weight: .regular))
                    })
                }
                Text("\(userProfileVM.user.username) · \(userProfileVM.user.karma) karma")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.black)
                    .padding(.bottom, 10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
    }
}

struct userProfileBtnView: View {
    @ObservedObject var userProfileVM:  UserProfileViewModel
    
    @Binding var rightSide: Bool
    @Binding var isActive: Bool
    
    // MARK: - ?? 중위연산사 두 값 isFollowed와 false를 비교, 왼쪽 값이 nil인 경우 오른쪽 값 반환
    var isFollowed: Bool { return userProfileVM.user.isFollowed ?? false}
    
    let user: UserModel
    
    var body: some View {
        if userProfileVM.user.isCurrentUser {
            NavigationLink(
                destination: EditUserProfileView(viewModel: EditUserProfileViewModel(user: user), rightSide: $rightSide, isActive: $isActive)
                , label: {
                    Text("Edit")
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .foregroundColor(.white)
                        .background(Color("Blue"))
                        .cornerRadius(20)
                })
        }
        else {
            HStack(alignment: .bottom) {
                Button(action: {
                    isFollowed ? userProfileVM.unfollow() : userProfileVM.follow()
                }, label: {
                    Text(isFollowed ? "Unfollow" : "Follow")
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .foregroundColor(.white)
                        .background(isFollowed ? Color(.systemGray6) : Color("Blue"))
                        .cornerRadius(20)
                })
            }
        }
    }
}

