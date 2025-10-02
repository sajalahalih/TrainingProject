//
//  ImageCellView.swift
//  TrainingProject
//
//  Created by saja allahaleh on 29/09/2025.
//

import Cocoa

class ImageCellView: NSTableCellView {

    // MARK: - Public properties

    var sfSymbol: SFSymbol? {
        didSet {
            populateData()
        }
    }

    // MARK: - IBOutlets

    @IBOutlet private weak var cellDescription: NSImageView!

    // MARK: - Private functions

    private func populateData() {
        let symbol = sfSymbol ?? .star
        cellDescription.image = NSImage(systemSymbolName: symbol.rawValue, accessibilityDescription: nil)
    }
}
