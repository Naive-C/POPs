//
//  ShortCellViewModel.swift
//  POPs
//
//  Created by Naive-C on 2022/06/08.
//

import SwiftUI

class ShortCellViewModel: ObservableObject {
    @Published var user: UserModel
    let post: PostModel
    
    init(user: UserModel, post: PostModel) {
        self.user = user
        self.post = post
        shortOwnerUser()
    }
    
    func shortOwnerUser() {
        COLLECTION_USERS.document(post.ownerUid).getDocument { snapshot, _ in
            guard let document = try? snapshot?.data(as: UserModel.self) else { return }
            self.user = document
        }
    }
}
