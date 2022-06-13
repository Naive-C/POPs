//
//  getUser.swift
//  POPs
//
//  Created by Naive-C on 2022/06/01.
//

import Foundation

class GetUserViewModel: ObservableObject {
    @Published var user: UserModel
    
    init(user: UserModel) {
        self.user = user
        getUserData()
    }
    
    func getUserData() {
        guard let uid = user.id else { return }
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let document = try? snapshot?.data(as: UserModel.self) else { return }
            self.user = document
        }
    }
}
