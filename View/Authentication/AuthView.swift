//
//  AuthView.swift
//  POPs
//
//  Created by Naive-C on 2022/04/25.
//

import Foundation
import SwiftUI

struct AuthView: View {
    @State var switchAuth: Bool = false
    
    var width = getRect().width
    
    var body: some View {
        HStack(spacing: 0) {
            LoginView(switchAuth: $switchAuth)
            RegistrationView(switchAuth: $switchAuth)
        }
        .frame(width: getRect().width * 2)
        .offset(x: switchAuth ?  -(width / 2) : (width / 2))
    }
}
