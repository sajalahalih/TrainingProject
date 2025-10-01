//
//  PersonListContentView.swift
//  TrainingProject
//
//  Created by saja allahaleh on 28/09/2025.
//

import Cocoa

protocol PersonListContentViewDelegate: AnyObject {
    func selectedRowDidChange(_ contentView: PersonListContentView, row: Int?)
}

class PersonListContentView: NSView {

    // MARK: - Public  Properties

    weak var delegate: PersonListContentViewDelegate?
    var people: [Person] = .init() {
        didSet {
            reloadData()
        }
    }

    // MARK: - IBOutlets

    @IBOutlet weak var personTableView: NSTableView! {
        didSet {
            personTableView.dataSource = self
            personTableView.delegate = self
            setupColumns()
        }
    }

    // MARK: - Private Function

    private func setupColumns() {
        personTableView.tableColumns.forEach {
            personTableView.removeTableColumn($0)
        }
        for column in PersonTableColumn.allCases {
            let tableColumn = NSTableColumn(identifier: column.identifier)
            tableColumn.title = column.localizedTitle
            tableColumn.width = column.width
            personTableView.addTableColumn(tableColumn)
        }
    }

    private func reloadData() {
        personTableView.reloadData()
    }
}

extension PersonListContentView: NSTableViewDelegate {

    // MARK: - Public functions

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let tableColumn = tableColumn else { return nil }
        let person = people[row]
        guard let column = PersonTableColumn( rawValue: tableColumn.identifier.rawValue) else { return nil }
        switch column {
        case .name, .id:
            let identifier = NSUserInterfaceItemIdentifier("TextCellView")
            guard let cellView = tableView
                .makeView(withIdentifier: identifier, owner: self) as? TextCellView else {
                return nil
            }
            cellView.title = (column == .name) ? person.name : String(person.id)
            return cellView
        case .description:
            let identifier = NSUserInterfaceItemIdentifier("DescriptionCellView")
            guard let cellView = tableView.makeView(withIdentifier: identifier, owner: self) as? DescriptionCellView else {
                return nil
            }
//            if let symbol = SFSymbolName(rawValue: rawData.description) {
//                cellView.descriptionText = symbol.rawValue
//            } else {
//                cellView.descriptionText = "questionmark.circle"
//            }
            cellView.descriptionText = person.description
            return cellView
        }
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        let selectedRow = personTableView.selectedRow
        if selectedRow >= 0 {
            delegate?.selectedRowDidChange(self, row: selectedRow)
        } else {
            delegate?.selectedRowDidChange(self, row: nil)
        }
    }

}
extension PersonListContentView: NSTableViewDataSource {

    // MARK: - Public functions

    func numberOfRows(in tableView: NSTableView) -> Int {
        return people.count
    }
}
