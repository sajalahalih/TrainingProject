//
//  LocalizationKey.swift
//  TrainingProject
//
//  Created by saja allahaleh on 30/09/2025.
//

import Foundation

enum LocalizationKey: String, LocalizationKeyEnumProtocol {
    case back
    case addPerson
    case infoMessage
    case selectedPerson
    case personListTableColumnName
    case personListTableColumnId
    case personListTableColumnDescription
    case star
    case starCircle
    case delete
}
protocol LocalizationKeyEnumProtocol: RawRepresentable<String> {
}

extension LocalizationKeyEnumProtocol {

  // MARK: - Public properties

  var text: String {
    return rawValue.localized
  }
}
