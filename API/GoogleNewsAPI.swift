//
//  GoogleNewsAPI.swift
//  POPs
//
//  Created by Naive-C on 2022/05/15.
//

import Foundation
import SwiftyJSON
import SwiftUI

class NewsAPI: ObservableObject {
    @Published var articles = [Article]()
    @Published var news = [Item]()
    
    init() {
        requestGoogleAPI()
        fetchNews()
    }
    
    func requestGoogleAPI() {
        let source: String = "https://newsapi.org/v2/everything?q=팝업스토어 오픈&sortBy=publishedAt&apiKey=5b6828da1dbf462a873b516dbc90aae7"
        
        let encodedQuery: String = source.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let queryURL: URL = URL(string: encodedQuery)!
        
        let requestURL = URLRequest(url: queryURL)
        
        URLSession.shared.dataTask(with: requestURL) { data, _, err in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            
            for i in json["articles"] {
                let title = i.1["title"].stringValue
                let url = i.1["url"].stringValue
                let image = i.1["urlToImage"].stringValue
                let id = i.1["publishedAt"].stringValue
                
//                let urlExpression = url.replacingOccurrences(of: "(https?://)", with: "", options: .regularExpression, range: nil)
                
                let splitId = id.components(separatedBy: "T")
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let convertDate = dateFormatter.date(from: splitId[0])
                
                let myDateFormatter = DateFormatter()
                myDateFormatter.dateFormat = "yyyy년 MM월 dd일"
                myDateFormatter.locale = Locale(identifier: "ko_KR")
                
                guard let convertDate = convertDate else {
                    return
                }

                let convertStr = myDateFormatter.string(from: convertDate)
                
                DispatchQueue.main.async {
                    self.articles.append(Article(id: convertStr, title: title, image: image, url: url))
                }
            }
        }.resume()
    }
    
    func fetchNews() {
        COLLECTION_NEWS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            self.news = documents.compactMap({ try? $0.data(as: Item.self ) })
            
            for news in self.news {
                self.articles.append(Article(id: news.id, title: news.title, image: news.image, url: news.url))
            }
        }
    }
}
