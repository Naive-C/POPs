//
//  CommunityListView.swift
//  POPs
//
//  Created by Naive-C on 2022/05/01.
//

import SwiftUI

struct CommunityListView: View {
    @ObservedObject var userVM: SearchViewModel
    
    @Binding var searchText: String
    
    @State var leftSide: Bool = false
    @State var isActive: Bool = false
    
    var commus: [CommunityModel] {
        return searchText.isEmpty ? userVM.commus : userVM.filteredCommunitys(searchText)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(commus) { commu in
                    if let user = AuthViewModel.shared.currentUser {
                        NavigationLink(destination: CommunityProfileView(user: user, commu: commu, isActive: $isActive, leftSide: $leftSide), label: {
                            UserJoinedCommunityCell(cellType: .member, user: user, commu: commu)
                                .padding(.horizontal)
                                .padding([.top, .bottom], 5)
                            
                        })
                    }
                }
            }
        }
    }
}
