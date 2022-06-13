//
//  UserService.swift
//  POPs
//
//  Created by Naive-C on 2022/04/28.
//

import Foundation
import Firebase

struct UserService {
    // MARK: - static func Ref https://sujinnaljin.medium.com/swift-class-func-vs-static-func-7e6feb264147
    
    static func follow(uid: String, completion: ((Error?) -> Void)?) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
       
        COLLECTION_FOLLOWING.document(currentUid)
            .collection("user-following").document(uid).setData([:]) { _ in
                COLLECTION_FOLLOWERS.document(uid).collection("user-followers")
                    .document(currentUid).setData([:], completion: completion)
            }
    }
    
    static func unfollow(uid: String, completion: ((Error?) -> Void)?) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
            .document(uid).delete { _ in
                COLLECTION_FOLLOWERS.document(uid).collection("user-followers")
                    .document(currentUid).delete(completion: completion)
            }
    }
    
    // MARK: - @escaping Property Ref https://jusung.github.io/Escaping-Closure/
    static func checkIfUserisFollowed(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        // MARK: - firebase snapshot.exists https://firebase.google.com/docs/database/web/read-and-write?hl=ko#web_value_events
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following")
            .document(uid).getDocument { snapshot, _ in
                guard let isFollowed = snapshot?.exists else { return }
                completion(isFollowed)
            }
    }
    (9)
    
}
