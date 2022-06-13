//
//  UserCommentViewModel.swift
//  POPs
//
//  Created by Naive-C on 2022/06/03.
//

import Foundation

class UserCommentViewModel: ObservableObject {
    @Published var comments = [CommentModel]()
    @Published var sortedComments = [CommentModel]()
    @Published var post: PostModel
    @Published var user: UserModel
    
    init(post: PostModel, user: UserModel) {
        self.post = post
        self.user = user
        fetchUserComment()
    }
    
    func fetchUserComment() {
        guard let uid = user.id else { return }
        guard let postId = post.id else { return }
        
        COLLECTION_POSTS.document(postId).collection("post-comments").whereField("ownerUid", isEqualTo: uid).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            self.comments += documents.compactMap({ try? $0.data(as: CommentModel.self) })
        }
    }
    
    func fetchCommentedPost() {
        
    }
    
    func sortedComments(commentsData: [CommentModel]) {
        self.sortedComments += commentsData.sorted(by: {$0.timestamp.seconds > $1.timestamp.seconds})
    }
    
    func timestampString(comment: CommentModel) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: comment.timestamp.dateValue(), to: Date()) ?? ""
    }
}
