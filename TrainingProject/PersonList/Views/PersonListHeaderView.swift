//
//  PersonListHeaderView.swift
//  TrainingProject
//
//  Created by saja allahaleh on 28/09/2025.
//

import Cocoa

protocol PersonListHeaderViewDelegate: AnyObject {
    func filterTextDidChange(_ headerView: PersonListHeaderView, text: String)
    func addButtonDidClicked(_ headerView: PersonListHeaderView)
}

class PersonListHeaderView: NSView, NSTextFieldDelegate {

    // MARK: - Public properties

    weak var delegate: PersonListHeaderViewDelegate?

    // MARK: - IBOutlets

    @IBOutlet weak var infoLabelDescription: NSTextField! {
        didSet {
           infoLabelDescriptionDetails()
        }
    }

    @IBOutlet weak var filtrationTextField: NSTextField! {
        didSet {
            filtrationTextField.delegate = self
        }
    }

    // MARK: - IBActions

    @IBAction private func addButtonAction(_ sender: Any?) {
        delegate?.addButtonDidClicked(self)
    }

    @IBAction private func clearButton(_ sender: NSButton) {
        delegate?.filterTextDidChange(self, text: "")
        filtrationTextField.stringValue = ""
    }

    // MARK: - Public functions

    func controlTextDidChange(_ obj: Notification) {
        delegate?.filterTextDidChange(self, text: filtrationTextField.stringValue)
    }

    // MARK: - Private Functions

    private func infoLabelDescriptionDetails() {
        let text = LocalizationKey.infoMessage.text
        let attributed = NSMutableAttributedString(string: text)
        let symbolAttachment = NSTextAttachment()
        let symbolImage = NSImage(
            systemSymbolName: "star.fill", accessibilityDescription: nil)
        symbolAttachment.image = symbolImage
        let symbolString = NSAttributedString(attachment: symbolAttachment)
        attributed.append(symbolString)
        infoLabelDescription.attributedStringValue = attributed
    }
}
