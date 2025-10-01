//
//  PersonTableView.swift
//  TrainingProject
//
//  Created by saja allahaleh on 30/09/2025.
//

import Cocoa

class PersonTableView: NSTableView {
    var rightClickedRow: Int = -1
    var rightClickedColumn: Int = -1

    override func menu(for event: NSEvent) -> NSMenu? {
        let point = convert(event.locationInWindow, from: nil)
        let row = self.row(at: point)
        let column = self.column(at: point)

        guard row >= 0, column >= 0 else { return nil }
        guard row < numberOfRows else { return nil }

        rightClickedRow = row
        rightClickedColumn = column

        let menu = NSMenu()
        let deleteMenuItem = NSMenuItem(
            title: "Delete",
            action: #selector(ViewController.deletePersonRow(_:)),
            keyEquivalent: ""
        )
        deleteMenuItem.target = nil
        menu.addItem(deleteMenuItem)

        return menu
    }
}
