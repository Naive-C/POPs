//
//  EditProfileViewModel.swift
//  POPs
//
//  Created by Naive-C on 2022/06/06.
//

import Foundation
import SwiftUI


class EditUserProfileViewModel: ObservableObject {
    let user: UserModel
    
    private var url: String = ""
    
    init(user: UserModel) {
        self.user = user
    }
    
    func saveUserDate(description: String, image: UIImage, social: String) {
        guard let uid = user.id else { return }
        
        if !social.isEmpty {
            url = "https://www.instagram.com/accounts/login/?next=/\(social)/"
        }
        
        ImageUploader.uploadImage(image: image, type: .profile) { imageUrl in
            COLLECTION_USERS.document(uid).updateData(["description": description,
                                                       "profileImageUrl": imageUrl,
                                                       "socialName": social,
                                                       "socialLink": self.url])
        }
    }
    
    func saveUserDate(description: String, social: String) {
        guard let uid = user.id else { return }
        
        if !social.isEmpty {
            url = "https://www.instagram.com/accounts/login/?next=/\(social)/"
        }
        
        COLLECTION_USERS.document(uid).updateData(["description": description,
                                                   "socialName": social,
                                                   "socialLink": self.url])
    }
    
    func saveCommuDate(description: String, image: UIImage) {
        guard let uid = user.id else { return }
        
        ImageUploader.uploadImage(image: image, type: .profile) { imageUrl in
            COLLECTION_USERS.document(uid).updateData(["description": description,
                                                       "communityProfileImageUrl": imageUrl])
        }
    }
    
    func saveCommuData(description: String) {
        guard let uid = user.id else { return }
        
        COLLECTION_USERS.document(uid).updateData(["description": description])
    }
}
