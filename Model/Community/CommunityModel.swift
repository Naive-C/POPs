//
//  CommuModel.swift
//  POPs
//
//  Created by Naive-C on 2022/04/27.
//

import FirebaseFirestoreSwift
import Firebase

struct CommunityModel: Identifiable, Decodable {
    let communityName: String
    var communityMember: Int
    let communityProfileImageUrl: String
    let ownerUsername: String
    let ownerUid: String
    let ownerImageUrl: String
    let description: String
    let commuType: String
    let timestamp: Timestamp
    @DocumentID var id: String?
}


