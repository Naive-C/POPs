//
//  CommunityProfileVIew.swift
//  POPs
//
//  Created by Naive-C on 2022/04/27.
//

import SwiftUI
import Kingfisher

struct CommunityProfileView: View {
    @Environment(\.presentationMode) var mode
    
    @ObservedObject var commuProfileVM: CommunityProfileViewModel
    @ObservedObject var commuVM: CommunitySlideMenuViewModel
    @ObservedObject var searchVM = SearchViewModel()
    
    @Binding var leftSide: Bool
    @Binding var isActive: Bool
    
    @State var searchText: String = ""
    
    var isJoined: Bool { return commuProfileVM.user.isJoined ?? false}
    
    let commu: CommunityModel
    let user: UserModel
    
    init(user: UserModel, commu: CommunityModel, isActive: Binding<Bool>, leftSide: Binding<Bool>) {
        self._isActive = isActive
        self._leftSide = leftSide
        self.user  = user
        self.commu = commu
        self.commuProfileVM = CommunityProfileViewModel(user: user, commu: commu)
        self.commuVM = CommunitySlideMenuViewModel(user: user, commu: commu)
    }
    
    var body: some View {
        VStack {
            CommunityProfileHeaderView(commuProfileVM: commuProfileVM, leftSide: $leftSide, isActive: $isActive)
            CommunitySlideView(commuVM: commuVM)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    searchVM.fetchCommus()
                    mode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.black)
                })
            }
        }
    }
}

struct CommunityProfileHeaderView: View {
    @ObservedObject var commuProfileVM: CommunityProfileViewModel
    
    @Binding var leftSide: Bool
    @Binding var isActive: Bool
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                KFImage(URL(string: commuProfileVM.commu.communityProfileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 60, height: 60)
                Spacer()
            }
            HStack() {
                Text(commuProfileVM.commu.communityName)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                Spacer()
                commuProfileBtnView(commuProfileVM: commuProfileVM, leftSide: $leftSide, isActive: $isActive)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("\(commuProfileVM.commu.communityMember) members")
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(.gray)
                Text(commuProfileVM.commu.description)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.black)
            }
            .padding(.top, 20)
        }
        .padding(.horizontal)
    }
}

struct commuProfileBtnView: View {
    @ObservedObject var commuProfileVM: CommunityProfileViewModel
    
    @Binding var leftSide: Bool
    @Binding var isActive: Bool
    // MARK: - ?? 중위연산사 두 값 isFollowed와 false를 비교, 왼쪽 값이 nil인 경우 오른쪽 값 반환
    var isJoined: Bool { return commuProfileVM.user.isJoined ?? false}
    
    var body: some View {
        if AuthViewModel.shared.userSession?.uid == commuProfileVM.commu.ownerUid {
            HStack {
                NavigationLink(destination: EditCommunityProfileView(viewModel: EditCommunityProfileViewModel(commu: commuProfileVM.commu), leftSide: $leftSide, isActive: $isActive)
                , label: {
                    Text("Edit")
                        .font(.system(size: 10, weight: .bold))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .foregroundColor(.white)
                        .background(Color("Blue"))
                        .cornerRadius(20)
                })
            }
        }
        else {
            HStack(alignment: .bottom) {
                Button(action: {
                    isJoined ? commuProfileVM.leave() : commuProfileVM.join()
                }, label: {
                    Text(isJoined ? "Leave" : "Join")
                        .font(.system(size: 10, weight: .bold))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .foregroundColor(isJoined ? .gray : .white)
                        .background(Color(isJoined ? .systemGray6 : .systemBlue))
                        .cornerRadius(20)
                })
            }
        }
    }
}
