//
//  EditCommuProfileViewModel.swift
//  POPs
//
//  Created by Naive-C on 2022/06/08.
//

import Foundation
import SwiftUI

class EditCommunityProfileViewModel: ObservableObject {
    let commu: CommunityModel
    
    init(commu: CommunityModel) {
        self.commu = commu
    }
    
    func saveCommuDate(description: String, image: UIImage) {
        guard let commuId = commu.id else { return }
        
        ImageUploader.uploadImage(image: image, type: .profile) { imageUrl in
            COLLECTION_COMMUNITYS.document(commuId).updateData(["description": description,
                                                       "communityProfileImageUrl": imageUrl])
        }
    }
    
    func saveCommuData(description: String) {
        guard let commuId = commu.id else { return }
        
        COLLECTION_COMMUNITYS.document(commuId).updateData(["description": description])
    }
}
