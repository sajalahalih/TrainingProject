//
//  PersonListViewModel.swift
//  TrainingProject
//
//  Created by saja allahaleh on 29/09/2025.
//

import Foundation

class PersonListViewModel {

    // MARK: - Public properties

    var people: [Person] = [] {
        didSet {
            savePersons()
        }
    }
    private(set) var filteredPersons: [Person] = []

    // MARK: - Private Properties

    private let userDefaultsKey = "personsData"

    // MARK: - Life Cycle

    init() {
        loadPersons()
        filteredPersons = people
    }

    // MARK: - Public functions

    func filterPersons(by name: String) {
        if name.isEmpty {
            filteredPersons = people
        } else {
            filteredPersons = people.filter { $0.name.localizedCaseInsensitiveContains(name) }
        }
    }

    // MARK: - Private Functions

    private func savePersons() {
        do {
            let data = try JSONEncoder().encode(people)
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        } catch {
            print("Failed to save persons: \(error)")
        }
    }

    private func loadPersons() {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else {
            return
        }
        do {
            people = try JSONDecoder().decode([Person].self, from: data)
        } catch {
            print("Failed to load persons: \(error)")
            people = []
        }
    }
}
