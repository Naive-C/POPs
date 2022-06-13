//
//  SelectTopicVIew.swift
//  POPs
//
//  Created by Naive-C on 2022/05/10.
//

import SwiftUI

struct JoinCommunityView: View {
    @Environment(\.presentationMode) var mode
    
    @ObservedObject var commuVM = JoinedCommuintyViewModel()
    
    @State var commuType: String = "Non"
    
    let tabs = ["Non","Food","Activity","Clothes"]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    ForEach(tabs, id: \.self) { tab in
                        Text(tab)
                            .font(.callout)
                            .foregroundColor(commuType == tab ? .white : .black)
                            .frame(maxWidth: .infinity)
                            .background {
                                if commuType == tab {
                                    Capsule()
                                        .fill(Color("Blue"))
                                }
                            }
                            .contentShape(Capsule())
                            .onTapGesture {
                                withAnimation{commuType = tab}
                                commuVM.fetchTypeCommunity(commuType: commuType)
                            }
                    }
                }
                .padding(.horizontal)
                
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(commuVM.typeCommu) { commu in
                            if let user = AuthViewModel.shared.currentUser {
                                HStack {
                                    AllCommunityCell(cellType: .description, commu: commu)
                                    Spacer()
                                    JoinCommu(commuProfileVM: CommunityProfileViewModel(user: user, commu: commu))
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                Button(action: {
                        AuthViewModel.shared.setUser(newUser: false)
                }, label: {
                    Text("Continue")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(gradient: Gradient(colors: summer[0]),
                                               startPoint: .leading,
                                            
                                               endPoint: .trailing)
                        )
                        .cornerRadius(20)
                })
                .padding(.horizontal)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        AuthViewModel.shared.setUser(newUser: false)
                    }, label: {
                        Text("Skip")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                    })
                }
            }
        }
    }
}

struct JoinCommu: View {
    @ObservedObject var commuProfileVM: CommunityProfileViewModel
    
    var isJoined: Bool { return commuProfileVM.user.isJoined ?? false}
    
    var body: some View {
        if commuProfileVM.user.id == commuProfileVM.commu.ownerUid {
            HStack {
                Button(action: {
                    
                }, label: {
                    Text("Edit")
                        .font(.system(size: 10, weight: .bold))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .foregroundColor(.white)
                        .background(Color(.systemBlue))
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
