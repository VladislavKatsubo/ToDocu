//
//  AppContext.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 15.07.23.
//

import Foundation

struct AppContext {

    let userDefaultsService: UserDefaultsServiceProtocol

    static func context() -> AppContext {
        let userDefaultsDependencies = UserDefaultsService.Dependencies()
        let userDefaultsService = UserDefaultsService(dependencies: userDefaultsDependencies)
        return AppContext(userDefaultsService: userDefaultsService)
    }
}
