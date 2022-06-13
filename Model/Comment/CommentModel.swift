//
//  Comment.swift
//  POPs
//
//  Created by Naive-C on 2022/04/30.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct CommentModel: Identifiable, Decodable {
    let username: String
    let postUid: String
    let postOwnerUid: String
    let profileImageUrl: String
    let commentText: String
    let timestamp: Timestamp
    let ownerUid: String
    @DocumentID var id: String?
}
