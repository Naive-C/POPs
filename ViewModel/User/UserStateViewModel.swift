//
//  FollwerViewModel.swift
//  POPs
//
//  Created by Naive-C on 2022/06/04.
//

import Foundation

class UserStateViewModel: ObservableObject {
    @Published var user: UserModel
    
    init(user: UserModel) {
        self.user = user
        fetchState()
    }
    
    func fetchState() {
        guard let uid = user.id else { return }
        
        COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { snapshot, _ in
            guard let followers = snapshot?.documents.count else { return }
            
            self.user.state = UserState(followers: followers)
        }
    }
}
