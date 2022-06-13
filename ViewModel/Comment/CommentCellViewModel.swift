//
//  CommentCellViewModel.swift
//  POPs
//
//  Created by Naive-C on 2022/06/01.
//

import Foundation

class CommentCellViewModel: ObservableObject {
    @Published var comment: CommentModel
    @Published var user: UserModel
    
    init(comment: CommentModel, user:UserModel) {
        self.comment = comment
        self.user = user
        getUser()
    }
    
    func getUser() {
        let uid = comment.ownerUid
        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let document = try? snapshot?.data(as: UserModel.self) else { return }
            self.user = document
        }
    }
    
    func commentDelete() {
        
    }
    
    var timestampString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: comment.timestamp.dateValue(), to: Date()) ?? ""
    }
}
