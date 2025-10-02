//
//  PersonListFooterView.swift
//  TrainingProject
//
//  Created by saja allahaleh on 28/09/2025.
//

import Cocoa

class PersonListFooterView: NSView {

    // MARK: - IBOutlets

    @IBOutlet private weak var selectedPerson: NSTextField!
    @IBOutlet private weak var selectedPersonsLabel: NSTextField! {
        didSet {
            selectedPersonsLabel.stringValue = LocalizationKey.selectedPerson.text
        }
    }

    // MARK: - Public functions

    func selectedPersonDidChange(_ person: Person?) {
        guard let person else { return }
        let text = "\(person.name) \(person.id)"
        selectedPerson.stringValue = text
    }
}
