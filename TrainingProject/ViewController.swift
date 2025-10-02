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
        contentView.tableActionDelegate = self
    }
}

extension ViewController: PersonListContentViewDelegate {

    // MARK: - Public functions

    func selectedRowDidChange(_ contentView: PersonListContentView, row: Int?) {
        if let row = row {
            let selectedPerson = contentView.people[row]
            footerView.selectedPersonDidChange(selectedPerson)
        } else {
            footerView.selectedPersonDidChange(nil)
        }
    }
}
extension ViewController: PersonListHeaderViewDelegate {

    // MARK: - Public functions

    func addButtonDidClicked(_ headerView: PersonListHeaderView) {
        let storyboard = NSStoryboard(name: Storyboard.main.rawValue, bundle: nil)
        guard let addPersonVC = storyboard.instantiateController(
            withIdentifier: AddPersonViewController.storyboardIdentifier)
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

extension ViewController: PersonTableViewDelegate {
    func didRequestDeleteRow(at index: Int) {
        guard index >= 0, index < viewModel.filteredPersons.count else { return }

        let personToDelete = viewModel.filteredPersons[index]

        if let row = viewModel.people.firstIndex(where: { $0.id == personToDelete.id }) {
            viewModel.people.remove(at: row)
        }

        viewModel.filterPersons(by: "")
        contentView.people = viewModel.filteredPersons
    }
}

extension AddPersonViewController: AddPersonViewModelDelegate {
    func addingPersonDidStart() {
        progressIndicator.isHidden = false
        addPersonButton.isEnabled = false
    }

    func addingPersonDidFinish(_ person: Person?) {
        progressIndicator.isHidden = true
        addPersonButton.isEnabled = true

        if let person {
            delegate?.personDidAdd(self, person: person)
            dismiss(self)
        }
    }
}

extension NSViewController {

    class var storyboardIdentifier: String {
        return String(describing: Self.self)
    }
}
// instantiate the add person view controller from the code and the controller in the storyboard
// present it as sheet
// sheet vs modal
