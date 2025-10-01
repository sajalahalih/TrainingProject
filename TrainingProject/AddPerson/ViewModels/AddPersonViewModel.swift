//
//  AddPersonViewModel.swift
//  TrainingProject
//
//  Created by saja allahaleh on 29/09/2025.
//

import Foundation

protocol AddPersonViewModelDelegate: AnyObject {
    func addingPersonDidStart()
    func addingPersonDidFinish(_ person: Person?)
}

class AddPersonViewModel {

    // MARK: - Public Properties

    let symbols: [SFSymbolName] = [.star, .starCircle]
    weak var delegate: AddPersonViewModelDelegate?

    // MARK: - Public functions

    /// Handles async creation
    func addPerson(name: String, symbol: SFSymbolName) {
        delegate?.addingPersonDidStart()
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) { [weak self] in
            let person = self?.createPerson(name: name, symbol: symbol)

            DispatchQueue.main.async {
                self?.delegate?.addingPersonDidFinish(person)
            }
        }
    }

    // MARK: - Public functions

    func createPerson(name: String, symbol: SFSymbolName) -> Person? {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else { return nil }
        let person = Person(name: name, description: symbol.rawValue)
        return person
    }
}
