//
//  MainView.swift
//  POPs
//
//  Created by Naive-C on 2022/04/06.
//

import SwiftUI

struct MainView: View {
    @State var ShowLeftSideMenu: Bool = false
    @State var ShowRightSideMenu: Bool = false
    
    @State var offset: CGFloat = 0
    @State var lastStoredOffset: CGFloat = 0
    
    let sideBarWidth = getRect().width - 90
    
    let user: UserModel
    
    var body: some View {
        NavigationView {
            HStack(spacing: 0) {
                JoinedCommunitySideMenu(leftSide: $ShowLeftSideMenu, user: user)
                MainTabView(ShowLeftSideMenu: $ShowLeftSideMenu, ShowRightSideMenu: $ShowRightSideMenu, user: user)
                MyPageMenu(rightSide: $ShowRightSideMenu,user: user)
            }
            .background(Color.white)
            .frame(width: getRect().width + (sideBarWidth * 2))
            .offset(x: offset)
            
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
        .onChange(of: ShowLeftSideMenu) { newValue in
            
            if ShowLeftSideMenu && offset == 0{
                withAnimation {
                    offset = sideBarWidth
                    lastStoredOffset = offset
                }
            }
            
            if !ShowLeftSideMenu && offset == sideBarWidth{
                withAnimation {
                    offset = 0
                    lastStoredOffset = 0
                }
            }
        }
        .onChange(of: ShowRightSideMenu) { newValue in
            
            if ShowRightSideMenu && offset == 0{
                withAnimation {
                    offset = -sideBarWidth
                    lastStoredOffset = offset
                }
            }
            
            if !ShowRightSideMenu && offset == -sideBarWidth{
                withAnimation {
                    offset = 0
                    lastStoredOffset = 0
                }
            }
        }
    }
}
