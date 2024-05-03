//
//  Helper.swift
//  In App Purchase
//
//  Created by Kerem Demir on 3.05.2024.
//

import Foundation

enum Product: String, CaseIterable {
    case diamond_500
    case diamond_1000
    case diamond_2000
    case diamond_5000
    
    var count: Int {
        switch self {
        case .diamond_500:
            return 500
        case .diamond_1000:
            return 1000
        case .diamond_2000:
            return 2000
        case .diamond_5000:
            return 5000
        }
    }
}
