//
//  AddPersonView.swift
//  TrainingProject
//
//  Created by saja allahaleh on 29/09/2025.
//

import Cocoa
import Carbon.HIToolbox

protocol AddPersonViewControllerDelegate: AnyObject {
    func personDidAdd(_ sender: AddPersonViewController, person: Person)
}

class AddPersonViewController: NSViewController {

    // MARK: - Public properties

    weak var delegate: AddPersonViewControllerDelegate?

    // MARK: - Private properties

    private let viewModel = AddPersonViewModel()
    private var escMonitor: Any?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        viewModel.delegate = self
        setupDescriptionList()
        setupEscKeyMonitor()
    }
    deinit {
        removeEscKeyMonitor()
    }

    // MARK: - IBOutlets

    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var descriptionList: NSPopUpButton! {
        didSet {
            descriptionList.removeAllItems()
        }
    }
    @IBOutlet weak var backButton: NSButton!
    @IBOutlet weak var addPersonButton: NSButton!
    @IBOutlet weak var progressIndicator: NSProgressIndicator! {
        didSet {
            progressIndicator.startAnimation(self)
            progressIndicator.isHidden = true
        }
    }

    // MARK: - IBActions

    @IBAction private func addPersonButton(_ sender: NSButton) {
            guard let selectedItem = descriptionList.selectedItem,
                  let symbolName = selectedItem.representedObject as? String,
                  let symbol = SFSymbol(rawValue: symbolName) else {
                return
            }
            viewModel.addPerson(name: nameTextField.stringValue, symbol: symbol)
        }

    @IBAction func cancelButton(_ sender: NSButton) {
        dismiss(self)
    }

    // MARK: - Private functions

    private func initViews() {
        backButton?.title = LocalizationKey.back.text
        addPersonButton?.title = LocalizationKey.addPerson.text
    }

    private func makeMenuItem(for symbol: SFSymbol) -> NSMenuItem {
        let menuItem = NSMenuItem(title: symbol.title, action: nil, keyEquivalent: "")
        menuItem.image = NSImage(systemSymbolName: symbol.rawValue,
                                 accessibilityDescription: symbol.rawValue)
        menuItem.representedObject = symbol.rawValue
        return menuItem
    }

    private func setupDescriptionList() {
        descriptionList.removeAllItems()
        guard let menu = descriptionList.menu else {
            return
        }
        for sfSymbol in viewModel.symbols {
            let menuItem = makeMenuItem(for: sfSymbol)
            menu.addItem(menuItem)
        }
    }

    private func setupEscKeyMonitor() {
        escMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            if event.keyCode == kVK_Escape { /// Esc
                self?.dismiss(self)
                return nil
            }
            return event
        }
    }
    private func removeEscKeyMonitor() {
        if let escMonitor {
            NSEvent.removeMonitor(escMonitor)
            self.escMonitor = nil
        }
    }
}
