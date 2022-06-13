////
////  NewsViewModel.swift
////  POPs
////
////  Created by Naive-C on 2022/06/06.
////
//
//import Foundation
//
//class NewsViewModel: ObservableObject {
//    @Published var news = [Item]()
//    
//    init() {
//        fetchNews()
//    }
//    
//    func fetchNews() {
//        COLLECTION_NEWS.getDocuments { snapshot, _ in
//            guard let documents = snapshot?.documents else { return }
//            
//            self.news = documents.compactMap({ try? $0.data(as: Item.self ) })
//        }
//    }
//}
