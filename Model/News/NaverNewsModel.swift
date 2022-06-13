//
//  NewsModel.swift
//  POPs
//
//  Created by Naive-C on 2022/05/11.
//

import Foundation

// MARK: - Item
struct Item: Decodable{
    let id: String
    let title: String
    let image: String
    let url: String
}
