//
//  SearchView.swift
//  POPs
//
//  Created by Naive-C on 2022/04/07.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var searchVM = SearchViewModel()
    
    @State private var searchText: String = ""
    @State private var isSearchMode: Bool = false
    
    var body: some View {
        VStack {
            SearchBar(inputText: $searchText, isEditing: $isSearchMode)
                .padding(.horizontal)
            
            ScrollView {
                
                ZStack {
                    CommunityListView(userVM: searchVM, searchText: $searchText)
                }
            }
        }
    }
}
