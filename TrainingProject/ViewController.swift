//
//  ViewController.swift
//  TrainingProject
//
//  Created by saja allahaleh on 28/09/2025.
//

import Cocoa

class ViewController: NSViewController {

    // MARK: - Public properties

    let viewModel = PersonListViewModel()

    // MARK: - IBOutlets

    @IBOutlet weak var headerView: PersonListHeaderView! {
        didSet {
            headerView.delegate = self
        }
    }
    @IBOutlet weak var contentView: PersonListContentView! {
        didSet {
            contentView.delegate = self
        }
    }
    @IBOutlet weak var footerView: PersonListFooterView!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.people = viewModel.people
        //  contentView.delegate = footerView
    }
}

extension ViewController: PersonListContentViewDelegate {

    // MARK: - Public functions

    func selectedRowDidChange(_ contentView: PersonListContentView, row: Int?) {
        if let row = row {
            let selectedPerson = contentView.people[row]
            footerView.selectedPersonDidChange(selectedPerson)
            print("person selected:\(selectedPerson.name)")
        } else {
            footerView.selectedPersonDidChange(nil)
        }
    }
}
extension ViewController: PersonListHeaderViewDelegate {

    // MARK: - Public functions

    func addButtonDidClicked(_ headerView: PersonListHeaderView) {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        guard let addPersonVC = storyboard.instantiateController(
                withIdentifier: "AddPersonViewController")
                as? AddPersonViewController
        else {return }
        addPersonVC.delegate = self
        self.presentAsSheet(addPersonVC)
       // self.presentAsModalWindow(addPersonVC)

    }

    func filterTextDidChange(_ headerView: PersonListHeaderView, text: String) {
        viewModel.filterPersons(by: text)
        contentView.people = viewModel.filteredPersons
    }
}
extension ViewController: AddPersonViewControllerDelegate {

    // MARK: - Public functions

    func personDidAdd(_ sender: AddPersonViewController, person: Person) {
        viewModel.people.append(person)
        contentView.people = viewModel.people
    }
}

extension ViewController {

    @IBAction func deletePersonRow(_ sender: Any?) {
        guard let table = contentView.personTableView as? PersonTableView else { return }
        let row = table.rightClickedRow
        guard row >= 0, row < viewModel.filteredPersons.count else { return }

        let personToDelete = viewModel.filteredPersons[row]

        // Remove from people array
        if let index = viewModel.people.firstIndex(where: { $0.id == personToDelete.id }) {
            viewModel.people.remove(at: index)
        }

        // Refresh filtered list
        viewModel.filterPersons(by: "")
        contentView.people = viewModel.filteredPersons

        print("🗑 Deleted person: \(personToDelete.name)")
    }
}

// instantiate the add person view controller from the code and the controller in the storyboard
// present it as sheet
// sheet vs modal
