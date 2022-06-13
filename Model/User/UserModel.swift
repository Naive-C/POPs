//
//  User.swift
//  POPs
//
//  Created by Naive-C on 2022/04/27.
//

import FirebaseFirestoreSwift

// MARK: - Document Propertiy Ref https://stackoverflow.com/questions/61393439/swift-firebase-custom-object-with-document-id
struct UserModel: Identifiable, Decodable{
    let email: String
    let username: String
    let profileImageUrl: String
    let profileBackgroundImageUrl: String
    var karma: Int
    var state: UserState?
    var description: String?
    var socialName: String?
    var socialLink: String?
    @DocumentID var id: String?
    
    var isFollowed: Bool? = false
    var isJoined: Bool? = false
    var newUser: Bool = true
    var isCurrentUser: Bool { return AuthViewModel.shared.userSession?.uid == id }
}

struct UserState: Decodable {
    var followers: Int
}
