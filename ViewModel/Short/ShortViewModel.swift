//
//  ShortViewModel.swift
//  POPs
//
//  Created by Naive-C on 2022/06/04.
//

import Foundation

class ShortViewModel: ObservableObject {
    @Published var commus = [CommunityModel]()
    @Published var posts = [PostModel]()
    @Published var sortedPosts = [PostModel]()

    func fetchAllShort() {
        COLLECTION_COMMUNITYS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            self.commus = documents.compactMap({ try? $0.data(as: CommunityModel.self) })
            
            for commu in self.commus {
                guard let commuId = commu.id else { return }
                
                COLLECTION_COMMUNITYS.document(commuId).collection("post").getDocuments { snapshot, _ in
                    guard let documents = snapshot?.documents else { return }
                    
                    self.posts = documents.compactMap({ try? $0.data(as: PostModel.self ) })
                    self.sortPosts(postsData: self.posts)
                }
            }
        }
    }
    
    func fetchTypeShort(type: String) {
        COLLECTION_COMMUNITYS.whereField("commuType", isEqualTo: type).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            self.commus = documents.compactMap({ try? $0.data(as: CommunityModel.self) })
            
            for commu in self.commus {
                guard let commuId = commu.id else { return }
                
                COLLECTION_COMMUNITYS.document(commuId).collection("post").getDocuments { snapshot, _ in
                    guard let documents = snapshot?.documents else { return }
                    
                    self.posts += documents.compactMap({ try? $0.data(as: PostModel.self ) })
                }
            }
        }
    }
    
    func sortPosts(postsData: [PostModel]) {
        self.sortedPosts += postsData.sorted(by: {$0.timestamp.seconds > $1.timestamp.seconds})
    }
}
