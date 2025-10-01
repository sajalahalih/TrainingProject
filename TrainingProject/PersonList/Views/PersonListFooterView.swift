//
//  PersonListFooterView.swift
//  TrainingProject
//
//  Created by saja allahaleh on 28/09/2025.
//

import Cocoa

class PersonListFooterView: NSView {

    // MARK: - IBOutlets

    @IBOutlet weak var selectedPerson: NSTextField!
    @IBOutlet weak var selectedPersonsLabel: NSTextField! {
        didSet {
            selectedPersonsLabel.stringValue = LocalizationKey.selectedPerson.text
        }
    }

    // MARK: - Public functions

    func selectedPersonDidChange(_ person: Person?) {
        guard let person else { return }
        let text = "\(person.name) \(person.id)"
        selectedPerson.stringValue = text
//        let attributed = NSMutableAttributedString(string: )
//        let symbolAttachment = NSTextAttachment()
//        let symbolImage = NSImage(systemSymbolName: "\(person.description)", accessibilityDescription: nil)
//        symbolAttachment.image = symbolImage
//        let symbolString = NSAttributedString(attachment: symbolAttachment)
//        attributed.append(symbolString)
//        selectedPerson.attributedStringValue = attributed
    }
}
