//
//  FeedCellViewModel.swift
//  POPs
//
//  Created by Naive-C on 2022/04/29.
//

import Foundation
import SwiftUI

class PostCellViewModel: ObservableObject {
    @Published var post: PostModel
    @Published var user: UserModel
    
    init(post: PostModel, user: UserModel) {
        self.post = post
        self.user = user
        checkIfUserLikePost()
    }
    
    var likeString: String {
        let label = post.likes == 1 ? "like" : "likes"
        return "\(post.likes) \(label)"
    }
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: post.timestamp.dateValue(), to: Date()) ?? ""
    }
    
    func like() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        let commuId = post.commuUid
        
        COLLECTION_POSTS.document(postId).collection("post-likes")
            .document(uid).setData([:]) { _ in
                COLLECTION_USERS.document(uid).collection("user-likes")
                    .document(postId).setData([:]) { _ in
                        COLLECTION_COMMUNITYS.document(commuId).collection("post").document(postId).updateData(["likes": self.post.likes + 1])
                        if uid != self.post.ownerUid {
                            COLLECTION_USERS.document(self.post.ownerUid).updateData(["karma": self.user.karma + 1])
                            NotificationViewModel.uploadNotification(toUid: self.post.ownerUid, type: .like, post: self.post)
                            self.user.karma   += 1
                        }
                        
                        self.post.didLike = true
                        self.post.likes   += 1
                    }
            }
    }
    
    func unlike() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        let commuId = post.commuUid
        
        COLLECTION_POSTS.document(postId).collection("post-likes").document(uid).delete { _ in
            COLLECTION_USERS.document(uid).collection("user-likes").document(postId).delete { _ in
                COLLECTION_COMMUNITYS.document(commuId).collection("post").document(postId).updateData(["likes": self.post.likes - 1])
                if self.post.ownerUid != uid {
                    COLLECTION_USERS.document(self.post.ownerUid).updateData(["karma": self.user.karma - 1])
                    self.user.karma   -= 1
                }
                self.post.didLike = false
                self.post.likes   -= 1
            }
        }
    }
    
    func checkIfUserLikePost() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        guard let postId = post.id else { return }
        
        COLLECTION_USERS.document(uid).collection("user-likes").document(postId)
            .getDocument { snapshot, _ in
                guard let didLike = snapshot?.exists else { return }
                self.post.didLike = didLike
            }
    }
    
    func postOwnerUser() {
        COLLECTION_USERS.document(post.ownerUid).getDocument { snapshot, _ in
            guard let document = try? snapshot?.data(as: UserModel.self) else { return }
            self.user = document
        }
    }
    
    func postDelete() {
        guard let postId = post.id else { return }
        
        COLLECTION_COMMUNITYS.document(post.commuUid).collection("post").document(postId).delete()
    }
}
