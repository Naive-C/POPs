//
//  Notification.swift
//  POPs
//
//  Created by Naive-C on 2022/04/30.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

struct NotificationModel:Identifiable, Decodable {
    var postId: String?
    let username: String
    let profileImageUrl: String
    let timestamp: Timestamp
    let type: NotificationType
    let uid: String
    @DocumentID var id: String?
    
    var isFollowed: Bool? = false
    var post: PostModel?
    var user: UserModel?
}

enum NotificationType: Int, Decodable {
    case like
    case comment
    case follow
    
    var notificationMessage: String {
        switch self {
        case .like: return " liked one of your posts"
        case .comment: return " commented on one of your post"
        case .follow: return " started following you"
        }
    }
}
