//
//  PersonListViewModelTest.swift
//  TrainingProjectTests
//
//  Created by saja allahaleh on 01/10/2025.
//

import Foundation
import XCTest
@testable import TrainingProject

final class PersonListViewModelTest: XCTestCase {
    private var viewModel: PersonListViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = PersonListViewModel()
        viewModel.people = [
            Person(name: "Alice", description: "star"),
            Person(name: "Bob", description: "starCircle"),
            Person(name: "Charlie", description: "star")
        ]
    }

    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }

    func testFilterPersonsWithEmptyString() {
        viewModel.filterPersons(by: "")

        XCTAssertEqual(viewModel.filteredPersons.count, 3)
    }

    func testFilterPersonsWithMatchingName() {
        viewModel.filterPersons(by: "ali")

        XCTAssertEqual(viewModel.filteredPersons.count, 1)
        XCTAssertEqual(viewModel.filteredPersons[0].name, "Alice")
    }

    func testFilterPersonsWithNoMatching() {
        viewModel.filterPersons(by: "kjhgf")

        XCTAssertEqual(viewModel.filteredPersons.count, 0)
    }

    func testSavePersonsWithUserDefaults() throws {
        let person = Person(name: "Alice", description: "star")
        viewModel.people = [person]

        guard let data = UserDefaults.standard.data(forKey: "personsData") else {
        XCTFail("No data saved to UserDefaults")
            return
        }
        let decoded = try JSONDecoder().decode([Person].self, from: data)

        XCTAssertEqual(decoded.count, 1)
        XCTAssertEqual(decoded.first?.name, "Alice")
        XCTAssertEqual(decoded.first?.description, "star")
    }
}
