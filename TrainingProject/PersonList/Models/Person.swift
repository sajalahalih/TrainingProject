//
//  Person.swift
//  TrainingProject
//
//  Created by saja allahaleh on 29/09/2025.
//

import Foundation

class Person: Codable {

    // MARK: - Public properties

    let name: String
    let id: String
    var description: String

    // MARK: - Life Cycle

    init(name: String, description: String) {
        self.name = name
        self.id = UUID().uuidString
        self.description = description
    }
}
