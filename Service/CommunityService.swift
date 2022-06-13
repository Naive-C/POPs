//
//  CommunityService.swift
//  POPs
//
//  Created by Naive-C on 2022/05/01.
//

import Foundation
import Firebase

struct CommunityService {
    let commu: CommunityModel
    
    
    static func join(commu: CommunityModel, completion: ((Error?) -> Void)?) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        guard let commuId = commu.id else { return }
        
        
        COLLECTION_JOINING.document(currentUid)
            .collection("user-joining").document(commuId).setData([:]) { _ in
                COLLECTION_JOINERS.document(commuId).collection("user-joiners")
                    .document(currentUid).setData([:]) { _ in
                        COLLECTION_COMMUNITYS.document(commuId).updateData(["communityMember": commu.communityMember + 1 ], completion: completion)
                        
                    }
            }
    }
    
    static func leave(commu: CommunityModel, completion: ((Error?) -> Void)?) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        guard let commuId = commu.id else { return }
        
        COLLECTION_JOINING.document(currentUid).collection("user-joining")
            .document(commuId).delete { _ in
                COLLECTION_JOINERS.document(commuId).collection("user-joiners")
                    .document(currentUid).delete { _ in
                        COLLECTION_COMMUNITYS.document(commuId).updateData(["communityMember": commu.communityMember - 1 ], completion: completion)
                    }
            }
    }
    
    static func checkIfUserisJoined(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        COLLECTION_JOINING.document(currentUid).collection("user-joining")
            .document(uid).getDocument { snapshot, _ in
                guard let isJoined = snapshot?.exists else { return }
                completion(isJoined)
            }
    }
    
}
