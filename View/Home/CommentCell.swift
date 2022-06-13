//
//  CommentCell.swift
//  POPs
//
//  Created by Naive-C on 2022/04/11.
//

import SwiftUI
import Kingfisher

struct CommentCell: View {
    @ObservedObject var commentCellVM: CommentCellViewModel
    
    @State var rightSide: Bool = false
    @State var isActive: Bool = false
    
    let comment: CommentModel
    let user: UserModel
    
    init(comment: CommentModel, user: UserModel) {
        self.comment = comment
        self.user = user
        commentCellVM = CommentCellViewModel(comment: comment, user: user)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                NavigationLink(destination: UserProfileView(user: commentCellVM.user, rightSide: $rightSide, isActive: $isActive), label: {
                    KFImage(URL(string: comment.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                Text(comment.username)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                })
                    
                Text("∙")
                Text(commentCellVM.timestampString)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.black.opacity(0.75))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(comment.commentText)
        }
    }
}

