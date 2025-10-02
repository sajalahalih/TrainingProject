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

    @IBOutlet private weak var personTableView: PersonTableView! {
        didSet {
            personTableView.dataSource = self
            personTableView.delegate = self
            setupColumns()
        }
    }
    weak var tableActionDelegate: PersonTableViewDelegate? {
        get { personTableView.actionDelegate }
        set { personTableView.actionDelegate = newValue }
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
            return makeTextCell(for: person, column: column)
        case .description:
            return makeImageCell(for: person)
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

    // MARK: - Private Functions

    private func getSFSymbol(description: String) -> SFSymbol? {
        if description == "star" {
            return .star
        } else if description == "star.circle" {
            return .starCircle
        } else {
            return nil
        }
    }

    private func makeTextCell(for person: Person, column: PersonTableColumn) -> TextCellView? {
        guard let cellView = personTableView.makeView(withIdentifier: TextCellView.cellIdentifier, owner: self) as? TextCellView else {
            return nil
        }
        cellView.title = (column == .name) ? person.name : String(person.id)
        return cellView
    }

    private func makeImageCell(for person: Person) -> ImageCellView? {
        guard let cellView = personTableView.makeView(withIdentifier: ImageCellView.cellIdentifier, owner: self) as? ImageCellView else {
            return nil
        }
        cellView.sfSymbol = getSFSymbol(description: person.description)
        return cellView
    }
}
extension PersonListContentView: NSTableViewDataSource {

    // MARK: - Public functions

    func numberOfRows(in tableView: NSTableView) -> Int {
        return people.count
    }
}
extension NSTableCellView {

    // MARK: - Public properties

    class var cellIdentifier: NSUserInterfaceItemIdentifier {
        return NSUserInterfaceItemIdentifier(rawValue: String(describing: Self.self))
    }
}
