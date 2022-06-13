//
//  UserCommentViewModel.swift
//  POPs
//
//  Created by Naive-C on 2022/05/10.
//

import Foundation
import SwiftUI
import Firebase

class UserSlideMenuViewModel: ObservableObject {
    @Published var commentedPosts = [PostModel]()
    @Published var posts = [PostModel]()
    @Published var user: UserModel
    
    init(user: UserModel) {
        self.user = user
        fetchUserPost()
    }
    
    func fetchUserPost() {
        guard let Uid = user.id else { return }
        COLLECTION_COMMUNITYS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            for i in 0 ..< documents.count {
                let commuId = documents[i].documentID
                
                COLLECTION_COMMUNITYS.document(commuId).collection("post").whereField("ownerUid", isEqualTo: Uid).getDocuments { snapshot, _ in
                    guard let documents = snapshot?.documents else { return }
                    
                    self.posts += documents.compactMap({ try? $0.data(as: PostModel.self) })
                }
            }
        }
    }
}
