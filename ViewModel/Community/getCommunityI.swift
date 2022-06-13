//
//  getCommunityI.swift
//  POPs
//
//  Created by Naive-C on 2022/06/02.
//

import Foundation

class getCommunity: ObservableObject {
    @Published var commu: CommunityModel
    
    init(commu: CommunityModel) {
        self.commu = commu
    }
    
    func getCommunity(commu: CommunityModel) {
        guard let commuId = commu.id else { return }
        COLLECTION_COMMUNITYS.document(commuId).getDocument { snapshot, _ in
            guard let document = try? snapshot?.data(as: CommunityModel.self) else { return }
            self.commu = document
        }
    }
}
