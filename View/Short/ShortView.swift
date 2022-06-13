//
//  ShortView.swift
//  POPs
//
//  Created by Naive-C on 2022/04/07.
//

import SwiftUI
import Kingfisher

struct ShortView: View {
    @State private var inputText: String = ""
    
    @Binding var ShowLeftSideMenu: Bool
    @Binding var ShowRightSideMenu: Bool
    
    let user: UserModel
    
    var body: some View {
        NavigationView {
            VStack {
                PostTypeButtons(user: user)
                ShortGridView(user: user)
                    .frame(maxHeight: .infinity)
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
            .navigationTitle("Short")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PostTypeButtons: View {
    @State var commuType: String = "All"
    
    let user: UserModel
    let tabs = ["Non","Food","Activity","Clothes"]
    
    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                NavigationLink(
                    destination: ShortTypeGridView(user: user, type: tab)
                        .navigationBarBackButtonHidden(true)
                    , label: {
                    Text(tab)
                        .font(.system(size: 14, weight: .bold))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .foregroundColor(.white)
                        .background(Color("Blue"))
                        .cornerRadius(10)
                })
            }
        }
        .padding(.top, 20)
    }
}
