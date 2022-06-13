//
//  FeedViewModel.swift
//  POPs
//
//  Created by Naive-C on 2022/04/29.
//

import Foundation
import SwiftUI

class PostViewModel: ObservableObject {
    @Published var posts = [PostModel]()
    @Published var sortedPosts = [PostModel]()
    @Published var commus = [CommunityModel]()
    @Published var commuIds = [String]()
    
    init() {
        fetchPost()
    }
    
    //    func fetchMyCommuPost() {
    //        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
    //
    //        COLLECTION_COMMUNITYS.whereField("ownerUid", isEqualTo: currentUid).getDocuments { snapshot, _ in
    //            guard let documents = snapshot?.documents else { return }
    //
    //            self.commus = documents.compactMap({ try? $0.data(as: CommunityModel.self) })
    //
    //            for commu in self.commus {
    //                guard let commuId = commu.id else { return }
    //
    //                COLLECTION_COMMUNITYS.document(commuId).collection("post").getDocuments { snapshot, _ in
    //                    guard let documents = snapshot?.documents else { return }
    //
    //                    self.posts = documents.compactMap({ try? $0.data(as: PostModel.self ) })
    //                }
    //            }
    //        }
    //    }
    //
    //    func fetchJoinedCommuPosts() {
    //        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
    //
    //        COLLECTION_JOINING.document(currentUid).collection("user-joining").getDocuments { snapshot, _ in
    //            guard let documents = snapshot?.documents else { return }
    //
    //            for i in 0 ..< documents.count {
    //                let commuId = documents[i].documentID
    //
    //                COLLECTION_COMMUNITYS.document(commuId).collection("post").getDocuments { snapshot, _ in
    //                    guard let documents = snapshot?.documents else { return }
    //
    //                    self.posts = documents.compactMap({ try? $0.data(as: PostModel.self )})
    //                }
    //            }
    //        }
    //    }
    
    func fetchPost() {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        COLLECTION_COMMUNITYS.whereField("ownerUid", isEqualTo: currentUid).getDocuments {snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            for document in documents {
                self.commuIds.append(document.documentID)
            }
            
            COLLECTION_JOINING.document(currentUid).collection("user-joining").getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                for document in documents {
                    self.commuIds.append(document.documentID)
                }
                
                for commuId in self.commuIds {
                    COLLECTION_COMMUNITYS.document(commuId).collection("post").getDocuments { snapshot, _ in
                        guard let documents = snapshot?.documents else { return }
                        self.posts += documents.compactMap({ try? $0.data(as: PostModel.self ) })
                        self.sort(postsData: self.posts)
                    }
                }
            }
        }
    }
    
    func allPost() {
        COLLECTION_COMMUNITYS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            self.commus = documents.compactMap({ try? $0.data(as: CommunityModel.self) })
            
            for commu in self.commus {
                guard let commuId = commu.id else { return }
                
                COLLECTION_COMMUNITYS.document(commuId).collection("post").getDocuments { snapshot, _ in
                    guard let documents = snapshot?.documents else { return }
                    
                    self.posts = documents.compactMap({ try? $0.data(as: PostModel.self ) })
                    self.sort(postsData: self.posts)
                }
            }
        }
    }
    
    func sort(postsData: [PostModel]) {
        self.sortedPosts = postsData.sorted(by: {$0.timestamp.seconds > $1.timestamp.seconds})
    }
}


