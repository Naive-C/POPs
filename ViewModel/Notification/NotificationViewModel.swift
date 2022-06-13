//
//  NotificationViewModel.swift
//  POPs
//
//  Created by Naive-C on 2022/04/30.
//

import Foundation
import SwiftUI
import Firebase

class NotificationViewModel: ObservableObject {
    @Published var notifications = [NotificationModel]()
    
    init() {
        fetchNotifications()
    }
    
    func fetchNotifications() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        
        let query = COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications")
            .order(by: "timestamp", descending: true)
        
        query.getDocuments{ snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.notifications = documents.compactMap({ try? $0.data(as: NotificationModel.self) })
        }
    }
    
    static func uploadNotification(toUid uid: String, type: NotificationType, post: PostModel? = nil) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        var data: [String: Any] = ["timestamp": Timestamp(date: Date()),
                                   "username": user.username,
                                   "uid": user.id ?? "",
                                   "profileImageUrl": user.profileImageUrl,
                                   "type": type.rawValue]
        
        
        if let post = post, let id = post.id {
            data["postId"] = id
        }
        
        COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").addDocument(data: data)
    }
}
