//
//  WritePostViewModel.swift
//  POPs
//
//  Created by Naive-C on 2022/04/28.
//

import Foundation
import SwiftUI
import Firebase
import MapKit

class UploadPostViewModel: ObservableObject {
//    @State var images: [String] = []
    
    func uploadPost(commu: CommunityModel, title: String, body: String, image: UIImage, latitude: CLLocationDegrees, longitude: CLLocationDegrees, addr: String) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let commuId = commu.id else { return }
        
        // MARK: - Timestamp Ref https://0urtrees.tistory.com/184
        ImageUploader.uploadImage(image: image, type: .post) { imageUrl in
            
            let data = ["title": title,
                        "body" : body,
                        "timestamp": Timestamp(date: Date()),
                        "latitude": latitude,
                        "longitude": longitude,
                        "address": addr,
                        "likes": 0,
                        "imageUrl": imageUrl,
                        "commuUid": commu.id ?? "",
                        "ownerUid": user.id ?? "",
                        "ownerImageUrl": user.profileImageUrl,
                        "ownerUsername": user.username] as [String : Any]
            
            COLLECTION_COMMUNITYS.document(commuId).collection("post").addDocument(data: data) { _ in
                print("Upload Post")
            }
        }
    }
}
    
//    func uploadPost(commu: CommunityModel, title: String, images: [UIImage], tagType: String) {
//        guard let user = AuthViewModel.shared.currentUser else { return }
//        guard let commuId = commu.id else { return }
//
//        // MARK: - Timestamp Ref https://0urtrees.tistory.com/184
//        ImageUploader.uploadImages(images: images, type: .post) { imageUrls in
//
//            let data = ["title": title,
//                        "timestamp": Timestamp(date: Date()),
//                        "tag": tagType,
//                        "likes": 0,
//                        "imageUrls": imageUrls,
//                        "ownerUid": user.id ?? "",
//                        "ownerImageUrl": user.profileImageUrl,
//                        "ownerUsername": user.username] as [String : Any]
//
//            COLLECTION_COMMUNITYS.document(commuId).collection("post").addDocument(data: data) { _ in
//                print("Upload Post")
//            }
//        }
//    }
