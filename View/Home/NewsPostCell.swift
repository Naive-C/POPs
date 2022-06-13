//
//  NewsCall.swift
//  POPs
//
//  Created by Naive-C on 2022/04/07.
//

import SwiftUI
import Kingfisher

struct NewsPostCell: View {
    let article: Article
    
    var body: some View {
        VStack {
        Link(destination: URL(string: article.url)!, label: {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(article.title)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                    Text(article.id)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.black)
                }
                Spacer()
                if let image = article.image {
                    if image != "" {
                        KFImage(URL(string: image))
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Rectangle())
                            .cornerRadius(10)
                            .overlay(
                                VStack {
                                    Spacer()
                                    Text("\(article.url)")
                                        .frame(maxWidth: .infinity)
                                        .background(RoundedCorners(color: Color.black.opacity(0.5), tl: 0, tr: 0, bl: 10, br: 10))
                                        .foregroundColor(.white)
                                        .lineLimit(1)
                                }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            )
                    }
                    else {
                        Image("blueRect")
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Rectangle())
                            .cornerRadius(10)
                            .overlay(
                                VStack {
                                    Spacer()
                                    Image(systemName: "globe")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.white)
                                    Text("\(article.url)")
                                        .frame(maxWidth: .infinity)
                                        .background(RoundedCorners(color: Color.black.opacity(0.5), tl: 0, tr: 0, bl: 10, br: 10))
                                        .foregroundColor(.white)
                                        .lineLimit(1)
                                }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            )
                    }
                }
            }
        })
        .padding(.horizontal)
        }
        .padding(.vertical, 10)
    }
}
