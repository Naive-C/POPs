//
//  DetailView.swift
//  POPs
//
//  Created by Naive-C on 2022/04/07.
//

import SwiftUI
import Kingfisher

struct PostDetail: View {
    @Environment(\.presentationMode) var mode
    
    @ObservedObject var postDetailVM: CommentViewModel
    @ObservedObject var feedVM: PostCellViewModel
    
    @State var text: String = ""
    
    @State var rightSide: Bool = false
    @State var isActive: Bool = false
    
    @State private var showCard: Bool = false
    
    var didLike: Bool { return feedVM.post.didLike ?? false }
    
    init(feedVM: PostCellViewModel) {
        self.postDetailVM = CommentViewModel(post: feedVM.post)
        self.feedVM = feedVM
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    NavigationLink(destination: UserProfileView(user: feedVM.user, rightSide: $rightSide, isActive: $isActive), label: {
                        KFImage(URL(string:postDetailVM.post.ownerImageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                    })
                    VStack(alignment: .leading) {
                        HStack {
                            Text(postDetailVM.post.ownerUsername)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.black)
                            Text("·")
                            Text(feedVM.timestampString)
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(.black.opacity(0.8))
                        }
                        NavigationLink(destination: MapAnnotationView(post: feedVM.post), label: {
                            Text(postDetailVM.post.address)
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(.black.opacity(0.8))
                        })
                    }
                    .padding(.horizontal, 5)
                
                    Spacer()
                    
                    if (AuthViewModel.shared.currentUser?.id == feedVM.post.ownerUid) {
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
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text(postDetailVM.post.title)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 5)
                        .padding(.horizontal)
                    Text(postDetailVM.post.body)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                        .padding(.top, 5)
                    
                    KFImage(URL(string: postDetailVM.post.imageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(maxHeight: 440)
                        .clipped()
                }
                HStack {
                    HStack{
                        Button(action: {
                            didLike ? feedVM.unlike() : feedVM.like()
                        }, label: {
                            HStack {
                                Image(systemName: didLike ? "heart.fill" : "heart")
                                    .foregroundColor(didLike ? Color.red : Color.black)
                                Text("\(feedVM.post.likes) likes")
                                    .font(.system(size: 14, weight: .semibold))
                            }
                        })
                    }
                    .frame(maxWidth: .infinity)
                    
                    NavigationLink(destination: PostDetail(feedVM: feedVM)) {
                        Image(systemName: "bubble.left")
                        Text("Comment")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .frame(maxWidth: .infinity)
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "square.and.arrow.up")
                        Text("Share")
                            .font(.system(size: 14, weight: .semibold))
                    })
                    .frame(maxWidth: .infinity)
                }
                Divider()
                
                LazyVStack(alignment: .leading) {
                    ForEach(postDetailVM.comments) { comment in
                        CommentCell(comment: comment, user: feedVM.user)
                            .padding(.horizontal)
                        Divider()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
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
        
        CustomInputView(text: $text, action: uploadComment)
    }
    func uploadComment() {
        postDetailVM.uploadComment(commentText: text)
        text = ""
    }
}

