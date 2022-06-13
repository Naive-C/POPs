//
//  ProfileViewModel.swift
//  POPs
//
//  Created by Naive-C on 2022/04/28.
//

import Foundation

class UserProfileViewModel: ObservableObject {
    @Published var user: UserModel
    @Published var follwers: Int = 0
    
    init(user: UserModel) {
        self.user = user
        checkIfUsersFollowed()
    }
    
    func follow() {
        guard let uid = user.id else { return }
        UserService.follow(uid: uid) { _ in
            NotificationViewModel.uploadNotification(toUid: uid, type: .follow)
            self.user.isFollowed = true
        }
    }
    
    func unfollow() {
        guard let uid = user.id else { return }
        UserService.unfollow(uid: uid) { _ in
            self.user.isFollowed = false
        }
    }
    
    func checkIfUsersFollowed() {
        guard !user.isCurrentUser else { return }
        guard let uid = user.id else { return }
        UserService.checkIfUserisFollowed(uid: uid) { isFollowed in
            self.user.isFollowed = isFollowed
        }
    }
}

class CommunityProfileViewModel: ObservableObject {
    @Published var commu: CommunityModel
    @Published var user: UserModel
    
    init(user: UserModel, commu: CommunityModel) {
        self.user  = user
        self.commu = commu
        checkIfUsersJoined()
        getCommuOwner()
    }
    
    func join() {
        CommunityService.join(commu: commu) { _ in
            self.commu.communityMember += 1
            self.user.isJoined = true
        }
    }
    
    func leave() {
        CommunityService.leave(commu: commu) { _ in
            self.commu.communityMember -= 1
            self.user.isJoined = false
        }
    }
    
    func checkIfUsersJoined() {
//        guard !commu.ownerUid else { return }
        guard let uid = commu.id else { return }
        CommunityService.checkIfUserisJoined(uid: uid) { isJoined in
            self.user.isJoined = isJoined
        }
    }
    
    func getCommuOwner() {
        let commuOwnerId = commu.ownerUid
        
        COLLECTION_USERS.document(commuOwnerId).getDocument { snapshot, _ in
            guard let document = try? snapshot?.data(as: UserModel.self) else { return }
            self.user = document
        }
    }
}
