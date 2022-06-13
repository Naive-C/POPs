//
//  LeftSideView.swift
//  POPs
//
//  Created by Naive-C on 2022/04/07.
//

import Foundation
import SwiftUI

struct JoinedCommunitySideMenu: View {
    @ObservedObject var commuVM = JoinedCommuintyViewModel()
    
    @Binding var leftSide: Bool
    
    @State var ShowModer: Bool = true
    @State var ShowCommu: Bool = true
    @State var isActive: Bool = false
    @State var rightSide: Bool = false
    
    let user: UserModel
    
    init(leftSide: Binding<Bool>, user: UserModel) {
        self._leftSide = leftSide
        self.user = user
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: {
                    self.ShowModer.toggle()
                }, label: {
                    Text("Moderating")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: ShowModer ? "chevron.down" : "chevron.right")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                })
            }
            LazyVStack(alignment: .leading) {
                ForEach(commuVM.moderateCommus) { commu in
                    NavigationLink(destination: CommunityProfileView(user: user, commu: commu, isActive: $isActive, leftSide: $leftSide)
                        , isActive: $isActive
                        , label: {
                        UserJoinedCommunityCell(cellType: .non, user: user, commu: commu)
                            .padding([.top, .bottom], 5)
                    })
                }
            }
            .opacity(ShowModer ? 1 : 0)
            .frame(height: ShowModer ? nil : 0)
            
            Divider()
            
            HStack {
                Button(action: {
                    self.ShowCommu.toggle()
                }, label: {
                    Text("Your Community")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: ShowCommu ? "chevron.down" : "chevron.right")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                })
            }
            LazyVStack(alignment: .leading) {
                ForEach(commuVM.joinedCommus) { commu in
                    NavigationLink(destination: CommunityProfileView(user: user, commu: commu, isActive: $isActive, leftSide: $leftSide), label: {
                        UserJoinedCommunityCell(cellType: .non, user: user, commu: commu)
                            .padding([.top, .bottom], 5)
                        
                    })
                }
            }
            .opacity(ShowCommu ? 1 : 0)
            .frame(height: ShowCommu ? nil : 0)
            
            Spacer()
            
            Divider()
            NavigationLink(destination: CreateCommunity(rightSide: $rightSide, leftSide: $leftSide), label: {
                Image(systemName: "plus")
                Text("Create a community")
            })
            .foregroundColor(.black)
            .font(.system(size: 16, weight: .regular))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.left, 10)
        .frame(width: getRect().width - 90)
        .navigationBarTitleDisplayMode(.inline)
    }
}
