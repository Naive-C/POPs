//
//  FollowersViewModel.swift
//  POPs
//
//  Created by Naive-C on 2022/06/04.
//

import Foundation
import FirebaseFirestoreSwift

class FollowersViewModel: ObservableObject {
    @Published var followers = [String]()
    @Published var users = [UserModel]()
    
    let user: UserModel
    
    init(user: UserModel) {
        self.user = user
        fetchFollowers()
    }
    
    func fetchFollowers() {
        guard let uid = user.id else { return }
        
        COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
    
            for document in documents {
                COLLECTION_USERS.document(document.documentID).getDocument { snapshot, _  in
                    guard let document = try? snapshot?.data(as: UserModel.self) else { return }
                    self.users.append(document)
                }
            }
        }
    }
}
