//
//  PersonTableView.swift
//  TrainingProject
//
//  Created by saja allahaleh on 30/09/2025.
//

import Cocoa

protocol PersonTableViewDelegate: AnyObject {
    func didRequestDeleteRow(at index: Int)
}

class PersonTableView: NSTableView {

    // MARK: - Public properties

    var rightClickedRow: Int = -1
    weak var actionDelegate: PersonTableViewDelegate?

    // MARK: - Public functions

    override func menu(for event: NSEvent) -> NSMenu? {
        let point = convert(event.locationInWindow, from: nil)
              let row = self.row(at: point)

              guard row >= 0, row < numberOfRows else { return nil }
              rightClickedRow = row

              let menu = NSMenu()
              let deleteMenuItem = NSMenuItem(
                title: LocalizationKey.delete.text,
                  action: #selector(deleteRowAction(_:)),
                  keyEquivalent: ""
              )
              deleteMenuItem.target = self
              menu.addItem(deleteMenuItem)

              return menu
          }

    @objc private func deleteRowAction(_ sender: Any?) {
            guard rightClickedRow >= 0 else { return }
            actionDelegate?.didRequestDeleteRow(at: rightClickedRow)
        }
}
