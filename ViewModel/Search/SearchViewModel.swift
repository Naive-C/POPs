//
//  SearchViewModel.swift
//  POPs
//
//  Created by Naive-C on 2022/04/27.
//

import Foundation
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var commus = [CommunityModel]()
//    @Published var users = [UserModel]()
    
    init() {
//        fetchUsers()
        fetchCommus()
    }
    
//    // MARK: - Mapping ref https://peterfriese.dev/posts/swiftui-firebase-codable/
//    func fetchUsers() {
//        COLLECTION_USERS.getDocuments { snapshot, _ in
//            guard let documents = snapshot?.documents else { return }
//            self.users = documents.compactMap({try? $0.data(as: UserModel.self)})
//        }
//    }
//    // MARK: - Search Filter https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-a-search-bar-to-filter-your-data
//    func filteredUsers(_ query: String) -> [UserModel] {
//        let lowercaseQuery = query.lowercased()
//        return users.filter({ $0.username.lowercased().contains(lowercaseQuery) })
//    }
    
    func fetchCommus() {
        COLLECTION_COMMUNITYS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.commus = documents.compactMap({try? $0.data(as: CommunityModel.self)})
        }
    }
    func filteredCommunitys(_ query: String) -> [CommunityModel] {
        let lowercaseQuery = query.lowercased()
        return commus.filter({ $0.communityName.lowercased().contains(lowercaseQuery) })
    }
}
