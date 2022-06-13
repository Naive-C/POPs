//
//  JoinedCommunityViewModel.swift
//  POPs
//
//  Created by Naive-C on 2022/05/12.
//

import Foundation
import Firebase

class JoinedCommuintyViewModel: ObservableObject {
    @Published var joinedCommus = [CommunityModel]()
    @Published var moderateCommus = [CommunityModel]()
    @Published var typeCommu = [CommunityModel]()
    @Published var commus = [CommunityModel]()
    
    init() {
        fetchJoinedCommunity()
        fetchModeratingCommunity()
        fetchTypeCommunity(commuType: "Non")
    }
    
    func fetchJoinedCommunity() {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        COLLECTION_JOINING.document(currentUid).collection("user-joining").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            for i in 0 ..< documents.count {
                let commuId = documents[i].documentID
                
                COLLECTION_COMMUNITYS.document(commuId).getDocument { snapshot, _ in
                    guard let document = try? snapshot?.data(as: CommunityModel.self) else { return }
                    self.joinedCommus.append(document)
                }
            }
        }
    }
    
    func fetchModeratingCommunity() {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        
        COLLECTION_COMMUNITYS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            self.commus = documents.compactMap({ try? $0.data(as: CommunityModel.self) })
            
            for commu in self.commus {
                if commu.ownerUid == currentUid {
                    self.moderateCommus.append(commu)
                }
            }
        }
    }
    
    func fetchTypeCommunity(commuType: String) {
        COLLECTION_COMMUNITYS.whereField("commuType", isEqualTo: commuType).getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            self.typeCommu = documents.compactMap({ try? $0.data(as: CommunityModel.self) })
        }
    }
}
