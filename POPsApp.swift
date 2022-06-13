//
//  POPsApp.swift
//  POPs
//
//  Created by Naive-C on 2022/04/06.
//

import SwiftUI
import Firebase

@main
struct POPsApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
        }
    }
}
