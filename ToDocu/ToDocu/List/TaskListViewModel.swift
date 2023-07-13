//
//  TaskListViewModel.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 13.07.23.
//

import Foundation

protocol TaskListViewModelProtocol {
    var onStateChange: ((TaskListResources.State) -> Void)? { get set }

    func launch()
    func reloadModels()
}

final class TaskListViewModel: TaskListViewModelProtocol {

    typealias Constants = TaskListResources.Constants.Mocks

    var onStateChange: ((TaskListResources.State) -> Void)?

    // MARK: - Public methods
    func launch() {
        setupModels()
    }

    func reloadModels() {

    }
}

private extension TaskListViewModel {
    // MARK: - Private methods
    func setupModels() {

    }
}
