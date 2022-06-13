//
//  UserCell.swift
//  POPs
//
//  Created by Naive-C on 2022/04/27.
//

import Foundation
import SwiftUI
import Kingfisher

struct UserCell: View {
    let user: UserModel
    
    var body: some View {
        HStack {
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 30, height: 30)
                .clipShape(Circle())
            Text(user.username)
                .font(.system(size: 14, weight: .semibold))
        }
    }
}
