////
////  NaverSearchNewsApi.swift
////  POPs
////
////  Created by Naive-C on 2022/05/11.
////
//
//import Foundation
//import UIKit
//
//class NaverNewsAPI {
//
//    static var shared = NaverNewsAPI()
//
//    let jsconDecoder: JSONDecoder = JSONDecoder()
//
//    func urlTaskDone() {
//        let item = dataManager.shared.searchResult?.items[0]
//    }
//
//    func requestAPIToNaver(queryValue: String) {
//
//        let clientID: String = "gZ_fX69_HC6tw53uw_xi"
//        let clientKEY: String = "ypFm9WmWpX"
//
//        let query: String  = "https://openapi.naver.com/v1/search/news.json?query=\(queryValue)"
//        let encodedQuery: String = query.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
//        let queryURL: URL = URL(string: encodedQuery)!
//
//        var requestURL = URLRequest(url: queryURL)
//        requestURL.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
//        requestURL.addValue(clientKEY, forHTTPHeaderField: "X-Naver-Client-Secret")
//
//        print(requestURL)
//        
//        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
//            guard error == nil else { print(error); return }
//            guard let data = data else { print(error); return }
//
//            do {
//                let searchInfo: Welcome = try self.jsconDecoder.decode(Welcome.self, from: data)
//                dataManager.shared.searchResult = searchInfo
//                self.urlTaskDone()
//            } catch {
//                print(fatalError())
//            }
//        }
//        task.resume()
//    }
//}
