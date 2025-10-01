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
    override var acceptsFirstResponder: Bool {
        return true
    }
    @IBOutlet weak var progressIndicator: NSProgressIndicator! {
        didSet {
            progressIndicator.startAnimation(self)
        }
    }

    // MARK: - Private properties

    private let viewModel = AddPersonViewModel()
    private var escMonitor: Any?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        setupDescriptionList()
        self.view.window?.makeFirstResponder(self)
        setupEscKeyMonitor()
        progressIndicator.isHidden = true
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

    // MARK: - IBActions

    @IBAction func addPersonButton(_ sender: NSButton) {
        addPersonButton.isEnabled = false
        progressIndicator.isHidden = false
//FIXME: Inside viewModel (in unit test should use expectation start animation)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self = self else { return }
            guard let selectedItem = descriptionList.selectedItem,
                  let symbolName = selectedItem.representedObject as? String,
                  let symbol = SFSymbolName(rawValue: symbolName),
                  let person = viewModel.createPerson(name: nameTextField.stringValue, symbol: symbol)
            else {
                progressIndicator.isHidden = true
                addPersonButton.isEnabled = true
                return
            }

            delegate?.personDidAdd(self, person: person)
            progressIndicator.stopAnimation(self)
            progressIndicator.isHidden = true
            addPersonButton.isEnabled = true
            dismiss(self)
        }
    }

    @IBAction func cancelButton(_ sender: NSButton) {
        dismiss(self)
    }

    // MARK: - Private functions

    private func initViews() {
        backButton?.title = LocalizationKey.back.text
        addPersonButton?.title = LocalizationKey.addPerson.text
    }

    private func setupDescriptionList() {
        descriptionList.removeAllItems()
        guard let menu = descriptionList.menu else { return }
        for sfSymbol in viewModel.symbols {
            let menuItem = NSMenuItem(title: sfSymbol.title, action: nil, keyEquivalent: "")
            menuItem.image = NSImage(systemSymbolName: sfSymbol.rawValue,
                                     accessibilityDescription: sfSymbol.rawValue)
            menuItem.representedObject = sfSymbol.rawValue
            menu.addItem(menuItem)
        }
    }

    private func setupEscKeyMonitor() {
        escMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
            if event.keyCode == kVK_Escape { // Esc
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

    // MARK: - Public functions

    // FIXME: Read about the hot keys / shortcut
    //    override func cancelOperation(_ sender: Any?) {
    //        self.dismiss(self)
    //    }
}
