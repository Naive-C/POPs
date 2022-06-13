//
//  CommunityViewModel.swift
//  POPs
//
//  Created by Naive-C on 2022/05/01.
//

import Foundation
import SwiftUI
import Firebase

class CommunityViewModel: ObservableObject {
    @Published var commus = [CommunityModel]()
    
    func createCommunity(commuName: String, image: UIImage, description: String, commuType: String) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        
        ImageUploader.uploadImage(image: image, type: .profile) { imageUrl in
            let data = ["communityName": commuName,
                        "communityMember": 0,
                        "communityProfileImageUrl": imageUrl,
                        "description": description,
                        "commuType": commuType,
                        "ownerImageUrl": user.profileImageUrl,
                        "ownerUsername": user.username,
                        "ownerUid": user.id ?? "",
                        "timestamp": Timestamp(date: Date())] as [String : Any]
            
            COLLECTION_COMMUNITYS.addDocument(data: data) { _ in
                print("create a Community")
            }
        }
    }
    

}
