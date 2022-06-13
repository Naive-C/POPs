//
//  NotificationCellViewModel.swift
//  POPs
//
//  Created by Naive-C on 2022/04/30.
//

import Foundation
import SwiftUI

class NotificationCellViewModel: ObservableObject {
    @Published var notification: NotificationModel
    @Published var commus = [CommunityModel]()
    
    init(notification: NotificationModel) {
        self.notification = notification
        checkIfUsersFollowed()
        fetchNotificationPost()
        fetchNotificationUser()
    }
    
    
    func follow() {
        UserService.follow(uid: notification.uid) { _ in
            NotificationViewModel.uploadNotification(toUid: self.notification.uid, type: .follow)
            self.notification.isFollowed = true
        }
    }
    
    func unfollow() {
        UserService.unfollow(uid: notification.uid) { _ in
            self.notification.isFollowed = false
        }
    }
    
    func checkIfUsersFollowed() {
        guard notification.type == .follow else { return }
        UserService.checkIfUserisFollowed(uid: notification.uid) { isFollowed in
            self.notification.isFollowed = isFollowed
        }
    }
    
    func fetchNotificationPost() {
        guard let postId = notification.postId else { return }
        
        COLLECTION_COMMUNITYS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            self.commus = documents.compactMap({ try? $0.data(as: CommunityModel.self) })
            
            for commu in self.commus {
                guard let commuId = commu.id else { return }
                
                COLLECTION_COMMUNITYS.document(commuId).collection("post").document(postId).getDocument { snapshot, _ in
                    guard let document = try? snapshot?.data(as: PostModel.self) else { return }
                    self.notification.post = document
                }
            }
        }
    }
    
    func fetchNotificationUser() {
        COLLECTION_USERS.document(notification.uid).getDocument { snapshot, _ in
            self.notification.user = try? snapshot?.data(as: UserModel.self)
        }
    }
}
