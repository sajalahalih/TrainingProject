//
//  TextCellView.swift
//  TrainingProject
//
//  Created by saja allahaleh on 29/09/2025.
//

import Cocoa

class TextCellView: NSTableCellView {

    // MARK: - Public properties

    var title: String? {
        didSet {
            populateData()
        }
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var titleField: NSTextField!

    // MARK: - Private functions

    private func populateData() {
        titleField.isSelectable = true
        titleField?.stringValue = title ?? "-"
        titleField?.lineBreakMode = .byTruncatingTail
        titleField.toolTip = title
    }
}
