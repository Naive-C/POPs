//
//  RightSideView.swift
//  POPs
//
//  Created by Naive-C on 2022/04/07.
//

import SwiftUI
import Kingfisher

struct MyPageMenu: View {
    @ObservedObject var userVM: GetUserViewModel
    
    @Binding var rightSide: Bool
    
    @State var leftSide: Bool = false
    @State var isActive: Bool = false
    
    let user: UserModel
    
    init(rightSide: Binding<Bool>, user: UserModel) {
        self._rightSide = rightSide
        self.user = user
        userVM = GetUserViewModel(user: user)
    }
    
    var body: some View {
        VStack(spacing: 15) {
            KFImage(URL(string: userVM.user.profileImageUrl))
                .resizable()
                .frame(width: 100, height: 100)
                .scaledToFill()
                .clipShape(Circle())
            Text(userVM.user.username)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
            
            
            Button(action: {
                
            }, label: {
                Image(systemName: "seal")
                VStack(alignment: .leading) {
                    Text("\(userVM.user.karma)")
                        .font(.system(size: 16, weight: .bold))
                    Text("Karam")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.gray)
                }
            })
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 20) {
                NavigationLink(
                    destination: UserProfileView(user: userVM.user, rightSide: $rightSide, isActive: $isActive)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarBackButtonHidden(true)
                    ,isActive: $isActive
                    ,label: {
                        Image(systemName: "person.crop.circle")
                            .foregroundColor(.gray)
                        Text("My Profile")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                    })
                NavigationLink(
                    destination:
                        CreateCommunity(rightSide: $rightSide, leftSide: $leftSide)
                    ,label: {
                    Image(systemName: "plus")
                            .foregroundColor(.gray)
                    Text("Create a community")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                })
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Button(action: {
                AuthViewModel.shared.signout()
            }, label: {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                Text("Logout")
            })
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom,safeArea().bottom == 0 ? 15 : 0)
        }
        .padding(.horizontal)
        .frame(width: getRect().width - 90)
        .frame(maxHeight: .infinity)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    @ViewBuilder
    func TabButton(title: String,image: String)->some View{
        NavigationLink {
            
            Text("\(title) View")
                .navigationTitle(title)
            
        } label: {
            
            HStack(spacing: 14){
                
                Image(image)
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 22, height: 22)
                
                Text(title)
            }
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity,alignment: .leading)
        }
    }
}
