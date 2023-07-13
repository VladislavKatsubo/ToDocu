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
    func didTap(at task: TaskListTableViewCell.Model)
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

    func didTap(at task: TaskListTableViewCell.Model) {
        print(task)
    }
}

private extension TaskListViewModel {
    // MARK: - Private methods
    func setupModels() {
        setupTaskListTableView()
    }

    func setupTaskListTableView() {
        let models = Constants.mockCells
        onStateChange?(.onTaskListTableView(models))
    }
}
