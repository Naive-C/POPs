//
//  CommunitySlideMenuViewModel.swift
//  POPs
//
//  Created by Naive-C on 2022/05/30.
//

import Foundation
import Firebase

class CommunitySlideMenuViewModel: ObservableObject {
    @Published var posts = [PostModel]()
    @Published var commu: CommunityModel
    @Published var user: UserModel
    
    init(user: UserModel, commu: CommunityModel) {
        self.user = user
        self.commu = commu
        fetchCommuPost()
        getCommuOwner()
    }
    
    func fetchCommuPost() {
        guard let commuId = commu.id else { return }
        
        COLLECTION_COMMUNITYS.document(commuId).collection("post").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            self.posts += documents.compactMap({ try? $0.data(as: PostModel.self) })
        }
    }
    
    func getCommuOwner() {
        let commuOwnerId = commu.ownerUid
        
        COLLECTION_USERS.document(commuOwnerId).getDocument { snapshot, _ in
            guard let document = try? snapshot?.data(as: UserModel.self) else { return }
            self.user = document
        }
    }
}
