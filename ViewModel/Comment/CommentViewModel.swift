//
//  CommentViewModel.swift
//  POPs
//
//  Created by Naive-C on 2022/04/30.
//

import Foundation
import SwiftUI
import Firebase

class CommentViewModel: ObservableObject {
    @Published var comments = [CommentModel]()
    @Published var userComments = [CommentModel]()
    
    let post: PostModel
    
    init(post: PostModel) {
        self.post = post
        fetchComment()
    }
    
    
    func uploadComment(commentText: String) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let postId = post.id else { return }
        
        let data: [String: Any] = ["username": user.username,
                                   "profileImageUrl": user.profileImageUrl,
                                   "ownerUid": user.id ?? "",
                                   "timestamp": Timestamp(date: Date()),
                                   "postOwnerUid": post.ownerUid,
                                   "postUid": post.id ?? "",
                                   "commentText": commentText]
        
        COLLECTION_POSTS.document(postId).setData([:]) { _ in
            COLLECTION_POSTS.document(postId).collection("post-comments").addDocument(data: data) { err in
                if let err = err {
                    print("Upload Comment \(err.localizedDescription)")
                    return
                }
                
                if user.id != self.post.ownerUid {
                    NotificationViewModel.uploadNotification(toUid: self.post.ownerUid, type: .comment, post: self.post)
                }
            }
        }
    }
    
    func fetchComment() {
        guard let postId = post.id else { return }
        
        let query = COLLECTION_POSTS.document(postId).collection("post-comments")
            .order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { snapshot, _ in
            guard let addedDocs = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            self.comments.append(contentsOf: addedDocs.compactMap({ try? $0.document.data(as: CommentModel.self) }))
        }
    }
}
