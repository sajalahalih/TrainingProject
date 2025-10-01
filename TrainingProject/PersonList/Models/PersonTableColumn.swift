//
//  PersonTableColumn.swift
//  TrainingProject
//
//  Created by saja allahaleh on 29/09/2025.
//

import AppKit

private struct Config {

    // MARK: - Public properties

    static let nameColumnWidth: CGFloat = 150
    static let identifierColumnWidth: CGFloat = 500
    static let descriptionColumnWidth: CGFloat = 100
}

enum PersonTableColumn: String, CaseIterable {
    case name
    case id
    case description
}

extension PersonTableColumn {

    // MARK: - Public properties

    var localizedTitle: String {
        switch self {
        case .name:
            return LocalizationKey.personTableName.text
        case .id:
            return LocalizationKey.personTableId.text
        case .description:
            return LocalizationKey.personTableDescription.text
        }
    }

    // MARK: - Public properties

    var identifier: NSUserInterfaceItemIdentifier {
        return NSUserInterfaceItemIdentifier(rawValue)
    }

    var width: CGFloat {
        switch self {
        case .name: return
            Config.nameColumnWidth
        case .id:
            return Config.identifierColumnWidth
        case .description:
            return Config.descriptionColumnWidth
        }
    }
}
