//
//  PostCall.swift
//  POPs
//
//  Created by Naive-C on 2022/04/07.
//

import SwiftUI
import Kingfisher

struct HomePostCell: View {
    @ObservedObject var feedVM: PostCellViewModel
    
    @State private var showCard: Bool = false
    
    @State var rightSide: Bool = false
    @State var isActive: Bool = false
    
    var didLike: Bool { return feedVM.post.didLike ?? false }
    
    init(feedVM: PostCellViewModel) {
        self.feedVM = feedVM
        feedVM.postOwnerUser()
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    NavigationLink(
                        destination: UserProfileView(user: feedVM.user, rightSide: $rightSide, isActive: $isActive)
                            .navigationBarBackButtonHidden(true)
                        , label: {
                            KFImage(URL(string:feedVM.user.profileImageUrl))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                        })
                    VStack(alignment: .leading) {
                        HStack {
                            Text(feedVM.post.ownerUsername)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.black)
                            Text("·")
                            Text(feedVM.timestampString)
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(.black.opacity(0.8))
                        }
                        NavigationLink(destination: MapAnnotationView(post: feedVM.post), label: {
                            Text(feedVM.post.address)
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(.black.opacity(0.8))
                        })
                    }
                    Spacer()
                    
                    if feedVM.user.isCurrentUser {
                        Button(action: {
                            self.showCard.toggle()
                        }, label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.gray)
                        })
                        .actionSheet(isPresented: $showCard, content: {
                            ActionSheet(
                                title: Text("Post Delete"),
                                buttons: [
                                    .default(Text("Delete"), action: {
                                        feedVM.postDelete()
                                    }),
                                    .cancel()
                                ])
                        })
                    }
                }
                .padding([.horizontal])
                
                NavigationLink(destination: PostDetail(feedVM: feedVM), label: {
                    VStack(alignment: .leading) {
                        Text("\(feedVM.post.title)")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                            .padding([.horizontal])
                            .padding(.top, 5)
                        
                        KFImage(URL(string: feedVM.post.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(maxHeight: 440)
                            .clipped()
                    }
                })
            }
            
            HStack {
                HStack{
                    Button(action: {
                        didLike ? feedVM.unlike() : feedVM.like()
                    }, label: {
                        HStack {
                            Image(systemName: didLike ? "heart.fill" : "heart")
                                .foregroundColor(didLike ? Color.red : Color.gray)
                            Text("\(feedVM.post.likes) likes")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.gray)
                        }
                    })
                }
                .frame(maxWidth: .infinity)
                
                NavigationLink(destination: PostDetail(feedVM: feedVM)) {
                    Image(systemName: "bubble.left")
                        .foregroundColor(.gray)
                    Text("Comment")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "square.and.arrow.up")
                    Text("Share")
                        .font(.system(size: 14, weight: .semibold))
                })
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity)
            }
            
            // MARK: Custom Action Sheet
            //            VStack {
            //                Button(action: {
            //
            //                }, label: {
            //                    Text("Delete")
            //                })
            //                Button(action: {
            //                    self.showCard.toggle()
            //                }, label: {
            //                    Text("Cancel")
            //                })
            //            }
            //            .opacity(showCard ? 1 : 0)
        }
        .padding(.vertical, 10)
    }
}

