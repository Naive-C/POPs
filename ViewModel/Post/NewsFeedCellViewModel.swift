////
////  NewsFeedViewModel.swift
////  POPs
////
////  Created by Naive-C on 2022/05/01.
////
//
//import Foundation
//import SwiftUI
//
//class NewsFeedCellViewModel: ObservableObject {
//    @Published var post: PostModel
//    
//    init(post: PostModel) {
//        self.post = post
//        checkIfUserLikePost()
//    }
//    
//    func like() {
//        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
//        guard let postId = post.id else { return }
//        
//        COLLECTION_NEWSPOSTS.document(postId).collection("post-likes")
//            .document(uid).setData([:]) { _ in
//                COLLECTION_USERS.document(uid).collection("user-likes")
//                    .document(postId).setData([:]) { _ in
//                        COLLECTION_NEWSPOSTS.document(postId).updateData(["likes": self.post.likes + 1])
//                        
//                        self.post.didLike = true
//                        self.post.likes   += 1
//                    }
//            }
//        
//    }
//    
//    func unlike() {
//        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
//        guard let postId = post.id else { return }
//        
//        COLLECTION_NEWSPOSTS.document(postId).collection("post-likes").document(uid).delete { _ in
//            COLLECTION_USERS.document(uid).collection("user-likes").document(postId).delete { _ in
//                COLLECTION_NEWSPOSTS.document(postId).updateData(["likes": self.post.likes - 1])
//                
//                self.post.didLike = false
//                self.post.likes  -= 1
//            }
//        }
//        
//    }
//    
//    func checkIfUserLikePost() {
//        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
//        guard let postId = post.id else { return }
//        
//        COLLECTION_USERS.document(uid).collection("user-likes").document(postId)
//            .getDocument { snapshot, _ in
//                guard let didLike = snapshot?.exists else { return }
//                self.post.didLike = didLike
//            }
//    }
//    
//}
