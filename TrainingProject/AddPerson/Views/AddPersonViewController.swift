//
//  AddPersonView.swift
//  TrainingProject
//
//  Created by saja allahaleh on 29/09/2025.
//

import Cocoa

protocol AddPersonViewControllerDelegate: AnyObject {
    func personDidAdd(_ sender: AddPersonViewController, person: Person)
}

class AddPersonViewController: NSViewController {

    // MARK: - Public properties

    weak var delegate: AddPersonViewControllerDelegate?
    override var acceptsFirstResponder: Bool {
        return true
    }
    @IBOutlet weak var progressIndicator: NSProgressIndicator!

    // MARK: - Private properties

    private let viewModel = AddPersonViewModel()
    private var escMonitor: Any?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        setupDescriptionList()
        self.view.window?.makeFirstResponder(self)
        escMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
              if event.keyCode == 53 { // Esc
                  self?.dismiss(self)
                  return nil
              }
              return event
          }
        progressIndicator.isHidden = true
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
        progressIndicator.startAnimation(self)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self = self else { return }

            guard let selectedItem = self.descriptionList.selectedItem,
                  let symbolName = selectedItem.representedObject as? String,
                  let symbol = SFSymbolName(rawValue: symbolName),
                  let person = self.viewModel.createPerson(name: self.nameTextField.stringValue, symbol: symbol)
            else {
                self.progressIndicator.stopAnimation(self)
                self.progressIndicator.isHidden = true
                self.addPersonButton.isEnabled = true
                return
            }

            self.delegate?.personDidAdd(self, person: person)
            self.progressIndicator.stopAnimation(self)
            self.progressIndicator.isHidden = true
            self.addPersonButton.isEnabled = true
            self.dismiss(self)
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

    // MARK: - Public functions

    // FIXME: Read about the hot keys / shortcut
    //    override func cancelOperation(_ sender: Any?) {
    //        self.dismiss(self)
    //    }

//    override func keyDown(with event: NSEvent) {
//        // ESC key has keyCode 53
//        if event.keyCode == 53 {
//            self.dismiss(self)
//        } else {
//            super.keyDown(with: event)
//        }
//    }
}
