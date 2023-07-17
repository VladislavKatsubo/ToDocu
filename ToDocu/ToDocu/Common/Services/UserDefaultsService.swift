//
//  UserDefaultsService.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 15.07.23.
//

import Foundation

protocol UserDefaultsServiceProtocolHolder {
    var userDefaultsService: UserDefaultsServiceProtocol { get }
}

protocol UserDefaultsServiceProtocol {

    // MARK: - Get
    func fetch<Value: Codable>(for key: String, fallback: Value) -> (isFallback: Bool, value: Value)
    func fetchOptional<Value: Codable>(for key: String) -> Value?

    // MARK: - Set
    func put<Value: Codable>(for key: String, value: Value)

    // MARK: - Delete
    func delete(for key: String)
}

struct UserDefaultsService: UserDefaultsServiceProtocol {

    struct Dependencies {
        let defaults: UserDefaults

        init(defaults: UserDefaults = .standard) {
            self.defaults = defaults
        }
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func fetch<Value: Codable>(for key: String, fallback: Value) -> (isFallback: Bool, value: Value) {
        guard let data = dependencies.defaults.data(forKey: key),
              let value = try? JSONDecoder().decode(Value.self, from: data) else {
            return (true, fallback)
        }
        return (false, value)
    }

    func fetchOptional<Value: Codable>(for key: String) -> Value? {
        guard let data = dependencies.defaults.data(forKey: key) else {
            return nil
        }
        return try? JSONDecoder().decode(Value.self, from: data)
    }

    func put<Value: Codable>(for key: String, value: Value) {
        if let encoded = try? JSONEncoder().encode(value) {

            dependencies.defaults.set(encoded, forKey: key)
        }
    }

    func delete(for key: String) {
        dependencies.defaults.removeObject(forKey: key)
    }
}
