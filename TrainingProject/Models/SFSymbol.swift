//
//  SFSymbol.swift
//  TrainingProject
//
//  Created by saja allahaleh on 29/09/2025.
//

import Foundation

enum SFSymbol: String, CaseIterable {
    case star = "star"
    case starCircle = "star.circle"
}

extension SFSymbol {
    var title: String {
        switch self {
        case .star:
            return LocalizationKey.star.text
        case .starCircle:
            return LocalizationKey.starCircle.text
        }
    }
}
