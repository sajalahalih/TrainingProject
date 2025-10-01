//
//  AddPersonViewModel.swift
//  TrainingProject
//
//  Created by saja allahaleh on 29/09/2025.
//

import Foundation

class AddPersonViewModel {

    // MARK: - Public Properties

    let symbols: [SFSymbolName] = [.star, .starCircle]

    // MARK: - Public functions

    func createPerson(name: String, symbol: SFSymbolName) -> Person? {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else { return nil }
        let person = Person(name: name, description: symbol.rawValue)
        return person
    }
}
