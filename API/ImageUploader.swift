//
//  ImageUploader.swift
//  POPs
//
//  Created by Naive-C on 2022/04/27.
//

import Foundation
import UIKit
import Firebase

enum UploadType {
    case profile
    case post
    
    var filePath: StorageReference {
        let filename = NSUUID().uuidString
        switch self {
        case .profile:
            return Storage.storage().reference(withPath: "/profile_image/\(filename)")
        case .post:
            return Storage.storage().reference(withPath: "/post_image/\(filename)")
        }
    }
}

struct ImageUploader {
    var imageUrls: [String] = []
    
    static func uploadImage(image: UIImage, type: UploadType, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        let ref = type.filePath
        
        ref.putData(imageData, metadata: nil) {_, err in
            if let err = err {
                print("Image upload failed \(err.localizedDescription)")
                return
            }
            
            ref.downloadURL {url, _ in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
    
    static func uploadImages(images: [UIImage], type: UploadType, completion: @escaping([String]) -> Void) {
        var imageUrls: [String] = []
        
        for image in images {
            guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
            
            let ref = type.filePath
            
            ref.putData(imageData, metadata: nil) {_, err in
                if let err = err {
                    print("Image upload failed \(err.localizedDescription)")
                    return
                }
                
                ref.downloadURL{ url, _ in
                    guard let imageUrl = url?.absoluteString else { return }
                    imageUrls.append(imageUrl)
                }
            }
        }
    }
}
