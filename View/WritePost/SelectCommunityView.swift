//
//  SelectCommunityView.swift
//  POPs
//
//  Created by Naive-C on 2022/04/12.
//

import SwiftUI

struct SelectCommunityView: View {
    @Environment(\.presentationMode) var mode
    
    @ObservedObject var searchVM = SearchViewModel()
    
    @State private var text: String = ""
    @State private var searchText:String = ""
    @State private var isEditing: Bool = false
    @State private var isPresented: Bool = false
    
    @Binding var isSelected: Bool
    @Binding var stored: Bool
    @Binding var commuStore: CommunityModel
    
    var commus: [CommunityModel] {
        return searchText.isEmpty ? searchVM.commus : searchVM.filteredCommunitys(searchText)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(inputText: $searchText, isEditing: $isEditing)
                    .padding(.top, 10)
                
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(commus) { commu in
                            Button(action: {
                                commuStore = commu
                                self.isSelected.toggle()
                                self.stored = true
                                mode.wrappedValue.dismiss()
                            }, label: {
                                if let user = AuthViewModel.shared.currentUser {
                                    UserJoinedCommunityCell(cellType: .description, user: user, commu: commu)
                                        .padding(.top, 10)
                                }
                            })
                        }
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("Post to")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        mode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.black)
                    })
                }
            }
        }
    }
}
