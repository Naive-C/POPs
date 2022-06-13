//
//  CommunutyCell.swift
//  POPs
//
//  Created by Naive-C on 2022/05/17.
//

import SwiftUI
import Kingfisher

struct AllCommunityCell: View {
    @ObservedObject var commuVM: getCommunity
    
    @State var cellType: CellType
    @State var commu: CommunityModel
    
    init(cellType: CellType, commu: CommunityModel) {
        self.cellType = cellType
        self.commu = commu
        commuVM = getCommunity(commu: commu)
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
                    Text(commuVM.commu.description)
                    .font(.system(size: 14, weight: .light))
                case .member:
                    Text(commu.communityName)
                        .font(.system(size: 16, weight: .bold))
                    Text("Community · \(commuVM.commu.communityMember) members")
                    .font(.system(size: 14, weight: .light))
                }
            }
            .foregroundColor(.black)
        }
    }
}
