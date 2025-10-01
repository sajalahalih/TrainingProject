//
//  AddPersonViewModelTests.swift
//  TrainingProjectTests
//
//  Created by saja allahaleh on 01/10/2025.
//

import Foundation
import XCTest
@testable import TrainingProject

final class AddPersonViewModelTests: XCTestCase {
    private var viewModel: AddPersonViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = AddPersonViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }

    func testCreatePersonValidInput() {
        let expectedPersonName = "Test"
        let expectedPersonSymbol = SFSymbolName.star
        let person = viewModel.createPerson(name: expectedPersonName, symbol: expectedPersonSymbol)
        XCTAssertEqual(person?.name, expectedPersonName)
        XCTAssertEqual(person?.description, expectedPersonSymbol.rawValue)
    }
}
