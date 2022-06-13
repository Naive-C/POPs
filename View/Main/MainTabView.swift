//
//  TabButtons.swift
//  POPs
//
//  Created by Naive-C on 2022/04/10.
//

import SwiftUI
import Firebase

struct MainTabView: View {
    @Binding var ShowLeftSideMenu: Bool
    @Binding var ShowRightSideMenu: Bool
    
    @State private var selectedIndex: Int = 0
    @State private var isPresented: Bool = false
    
    @State var currentTab = "house"
    
    let icons: [String] = ["house", "safari", "plus", "magnifyingglass", "bell"]
    
    let commu = CommunityModel(communityName: "",
                               communityMember: 0,
                               communityProfileImageUrl: "",
                               ownerUsername: "",
                               ownerUid: "",
                               ownerImageUrl: "",
                               description: "",
                               commuType: "",
                               timestamp: Timestamp(date: Date()))
    
    let user: UserModel
    
    var body: some View {
        VStack {
            ZStack {
                Spacer().fullScreenCover(isPresented: $isPresented,content: {
                    WritePostView(commu: commu)
                })
                
                switch selectedIndex {
                case 0:
                    HomeView(user: user, ShowLeftSideMenu: $ShowLeftSideMenu, ShowRightSideMenu: $ShowRightSideMenu)
                case 1:
                    ShortView(ShowLeftSideMenu: $ShowLeftSideMenu, ShowRightSideMenu: $ShowRightSideMenu, user: user)
                case 3:
                    SearchView()
                case 4:
                    NotificationView(ShowLeftSideMenu: $ShowLeftSideMenu, ShowRightSideMenu: $ShowRightSideMenu, user: user)
                    
                default:
                    Text("Default")
                }
            }
            .frame(width: getRect().width)
            
            HStack {
                ForEach(0 ..< 5, id: \.self) { num in
                    Spacer()
                    Button(action: {
                        if num == 2 {
                            self.isPresented.toggle()
                        }
                        else {
                            self.selectedIndex = num
                        }
                    }, label: {
                        Image(systemName: icons[num])
                            .resizable()
                            .scaledToFill()
                            .frame(width: 23, height: 23)
                            .foregroundColor(selectedIndex == num ? .black : Color(UIColor.lightGray))
                    })
                    Spacer()
                }
            }
            .frame(width: getRect().width)
            .padding(.top,10)
            .padding(.bottom,safeArea().bottom == 0 ? 15 : 0)
        }
        
    }
}
