//
//  SFSymbolName.swift
//  TrainingProject
//
//  Created by saja allahaleh on 29/09/2025.
//

import Foundation

enum SFSymbolName: String, CaseIterable {
    case star = "star"
    case starCircle = "star.circle"
}

extension SFSymbolName {
    var title: String {
        switch self {
        case .star:
            return "Star"
        case .starCircle:
            return "Star Circle"
        }
    }
}
