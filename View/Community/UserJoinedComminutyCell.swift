//
//  ComminutyCell.swift
//  POPs
//
//  Created by Naive-C on 2022/04/27.
//

import Foundation
import SwiftUI
import Kingfisher

enum CellType {
    case non
    case description
    case member
}

struct UserJoinedCommunityCell: View {
    @ObservedObject var commuCellVM: CommunityProfileViewModel
    
    @State var cellType: CellType
    
    let commu: CommunityModel
    let user: UserModel
    
    init(cellType: CellType, user: UserModel, commu: CommunityModel) {
        self.cellType = cellType
        self.user  = user
        self.commu = commu
        self.commuCellVM = CommunityProfileViewModel(user: user, commu: commu)
    }
    
    var body: some View {
        HStack {
            VStack {
            KFImage(URL(string: commu.communityProfileImageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 23, height: 23)
                .clipShape(Circle())
            }
            
            VStack(alignment: .leading) {
                
                switch cellType {
                case .non :
                    Text(commu.communityName)
                        .font(.system(size: 16, weight: .regular))
                case .description:
                    Text(commu.communityName)
                        .font(.system(size: 16, weight: .bold))
                    Text("Community · \(commu.description)")
                    .font(.system(size: 14, weight: .light))
                case .member:
                    Text(commu.communityName)
                        .font(.system(size: 16, weight: .bold))
                    Text("Community · \(commuCellVM.commu.communityMember) members")
                    .font(.system(size: 14, weight: .light))
                }
            }
            .foregroundColor(.black)
        }
    }
}

