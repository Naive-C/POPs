//
//  AuthTextField.swift
//  POPs
//
//  Created by Naive-C on 2022/04/24.
//

import Foundation
import SwiftUI

struct AuthButton: View {
    let image: String
    let company: String
    
    var body: some View {
        Button(action: {
            
        }, label: {
            Image(systemName: image)
            Text("Continue with \(company)")
        })
    }
}
