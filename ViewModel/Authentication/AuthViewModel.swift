//
//  AuthViewModel.swift
//  POPs
//
//  Created by Naive-C on 2022/04/27.
//

import SwiftUI
import UIKit
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: UserModel?
    @Published var users = [UserModel]()
    @Published var loginExecption: Bool = false
    
    static let shared = AuthViewModel()
    
    init() {
//        self.userSession = nil
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Login Failed \(err.localizedDescription)")
                self.loginExecption.toggle()
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.loginExecption = false
            self.fetchUser()
        }
    }
    
    func register(email: String, username: String, password: String, image:UIImage?) {
        guard let image = image else { return }
        
        ImageUploader.uploadImage(image: image, type: .profile) { imageUrl in
            Auth.auth().createUser(withEmail: email, password: password) { result, err in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }
                guard let user = result?.user else { return }
                print("Registered successful")
                
                let data = [
                    "email": email,
                    "username": username,
                    "profileImageUrl": imageUrl,
                    "profileBackgroundImageUrl": profile_background_image_url,
                    "karma": 0,
                    "uid": user.uid,
                    "newUser": true
                ] as [String : Any]
                
                COLLECTION_USERS.document(user.uid).setData(data) { _ in
                    print("Userdata upload successful")
                    self.userSession = user
                    self.fetchUser()
                }
            }
        }
    }
    
    func signout() {
        self.userSession = nil
        self.currentUser = nil
        try? Auth.auth().signOut()
    }
    
    func resetPassword() {
        
    }
    
    func setUser(newUser: Bool) {
        guard let uid = userSession?.uid else { return }
        
        COLLECTION_USERS.document(uid).updateData(["newUser": newUser]) { _ in
            self.fetchUser()
        }
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: UserModel.self) else { return }
            self.currentUser = user
        }
    }
    
    func userNameDuplicateCheck(name: String) {
        COLLECTION_USERS.whereField("username", isEqualTo: name).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            self.users = documents.compactMap({ try? $0.data(as: UserModel.self) })
        }
    }
}
