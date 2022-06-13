//
//  ContentView.swift
//  POPs
//
//  Created by Naive-C on 2022/04/21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        Group {
            if authVM.userSession == nil {
                AuthView()
            }
            else if authVM.currentUser?.newUser == true {
                    JoinCommunityView()
            }
            else {
                if let user = authVM.currentUser {
                    MainView(user: user)
                }
            }
        }
    }
}
