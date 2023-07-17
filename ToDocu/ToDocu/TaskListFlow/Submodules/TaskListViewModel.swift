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
    func didTapCell(at index: Int)
    func didTapTaskStatus(at index: Int)
    func didTapAddTaskButton()
    func didSwipeToDeleteTask(at index: Int)
}

final class TaskListViewModel: TaskListViewModelProtocol {

    typealias Constants = TaskListResources.Constants.Mocks

    private let context: AppContext
    private let handlers: TaskListResources.Handlers
    private let dataService: UserDefaultsServiceProtocol

    private var currentTasks: [TaskListTableViewCell.Model] = []
    var onStateChange: ((TaskListResources.State) -> Void)?

    // MARK: - Init
    init(context: AppContext, handlers: TaskListResources.Handlers) {
        self.context = context
        self.handlers = handlers
        self.dataService = context.userDefaultsService
    }

    // MARK: - Public methods
    func launch() {
        setupModels()
    }

    func reloadModels() {
        setupModels()
    }

    func didTapCell(at index: Int) {
        let model = currentTasks[index]
        self.handlers.onViewTask(model, index)
    }

    func didTapTaskStatus(at index: Int) {
        self.currentTasks[index].status.toggle()

        dataService.put(for: Constants.allTasksUserDefaultsKey, value: currentTasks)

        onStateChange?(.onReloadTableViewRow(index, currentTasks))
    }

    func didTapAddTaskButton() {
        self.handlers.onAddTask()
    }

    func didSwipeToDeleteTask(at index: Int) {
        self.currentTasks.remove(at: index)
        dataService.put(for: Constants.allTasksUserDefaultsKey, value: currentTasks)
    }
}

private extension TaskListViewModel {
    // MARK: - Private methods
    func setupModels() {
        setupTaskListTableView()
    }

    func setupTaskListTableView() {
        currentTasks.removeAll(keepingCapacity: true)
        guard let models: [TaskListTableViewCell.Model] = dataService.fetchOptional(for: Constants.allTasksUserDefaultsKey) else { return }
        self.currentTasks = models
        
        onStateChange?(.onTaskListTableView(models))
    }
}
