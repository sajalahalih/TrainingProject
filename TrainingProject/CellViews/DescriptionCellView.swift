//
//  DescriptionCellView.swift
//  TrainingProject
//
//  Created by saja allahaleh on 29/09/2025.
//

import Cocoa

class DescriptionCellView: NSTableCellView {

    // MARK: - Public properties

    var descriptionText: String? {
        didSet {
            populateData()
        }
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var cellDescription: NSImageView!

    // MARK: - Private functions

    private func populateData() {
        let symbol = descriptionText ?? "square.and.arrow.up"
        cellDescription.image = NSImage(systemSymbolName: symbol, accessibilityDescription: nil)
    }
}
