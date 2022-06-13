//
//  PostModel.swift
//  POPs
//
//  Created by Naive-C on 2022/04/28.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import MapKit

struct PostModel:Identifiable, Decodable {
    let commuUid: String
    let ownerUid: String
    let ownerUsername: String
    let ownerImageUrl: String
    let title: String
    let body: String
    let imageUrl: String
    var likes: Int
    let timestamp: Timestamp
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    let address: String
    @DocumentID var id: String?
    
    var didLike : Bool?
}
