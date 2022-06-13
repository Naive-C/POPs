//
//  SearchEndExtension.swift
//  POPs
//
//  Created by Naive-C on 2022/04/12.
//

import UIKit

extension UIApplication {
    func endEditing () {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
