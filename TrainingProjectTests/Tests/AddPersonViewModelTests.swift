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
    private var mockDelegate: MockAddPersonDelegate!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = AddPersonViewModel()
        mockDelegate = MockAddPersonDelegate()
        viewModel.delegate = mockDelegate
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockDelegate = nil
        try super.tearDownWithError()
    }

    func testCreatePersonValidInput() {
        let expectedPersonName = "Test"
        let expectedPersonSymbol = SFSymbolName.star
        let person = viewModel.createPerson(name: expectedPersonName, symbol: expectedPersonSymbol)
        XCTAssertEqual(person?.name, expectedPersonName)
        XCTAssertEqual(person?.description, expectedPersonSymbol.rawValue)
    }

    func testCreatePersonNil() {
        let expectedPersonSymbol = SFSymbolName.star
        let person = viewModel.createPerson(name: "", symbol: expectedPersonSymbol)
        XCTAssertNil(person)
    }

    func testSymbolsArray() {
        let symbols = viewModel.symbols
        XCTAssertEqual(symbols, [.star, .starCircle])
    }

    func testAddPerson_CreatesPersonAndCallsDelegate() {

        let expectationStart = expectation(description: "Delegate start called")
        let expectationFinish = expectation(description: "Delegate finish called")

        viewModel.addPerson(name: "Test", symbol: .star)
        XCTAssertTrue(mockDelegate.didStartCalled)
        expectationStart.fulfill()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            XCTAssertTrue(self.mockDelegate.didFinishCalled)
            XCTAssertEqual(self.mockDelegate.receivedPerson?.name, "Test")
            XCTAssertEqual(self.mockDelegate.receivedPerson?.description, SFSymbolName.star.rawValue)
            expectationFinish.fulfill()
        }

        wait(for: [expectationStart, expectationFinish], timeout: 3.0)
    }
}

class MockAddPersonDelegate: AddPersonViewModelDelegate {
    var didStartCalled = false
    var didFinishCalled = false
    var receivedPerson: Person?

    func addingPersonDidStart() {
        didStartCalled = true
    }

    func addingPersonDidFinish(_ person: Person?) {
        didFinishCalled = true
        receivedPerson = person
    }
}
