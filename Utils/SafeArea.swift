//
//  safeArea.swift
//  POPs
//
//  Created by Naive-C on 2022/04/20.
//

import Foundation
import SwiftUI

func safeArea()->UIEdgeInsets{
    let null = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
        return null
    }
    
    guard let safeArea = screen.windows.first?.safeAreaInsets else{
        return null
    }
    
    return safeArea
}
