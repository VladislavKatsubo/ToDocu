//
//  AddTaskViewModel.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 15.07.23.
//


import Foundation

protocol AddTaskViewModelProtocol {
    var onStateChange: ((AddTaskResources.State) -> Void)? { get set }

    func launch()
    func didTapCancel()
    func didTapDone()
    func didTapEdit()
    func setTaskTitle(_ title: String?)
    func setTaskDescription(_ description: String?)
}

final class AddTaskViewModel: AddTaskViewModelProtocol {

    typealias Constants = AddTaskResources.Constants.Mocks

    private let context: AppContext
    private let handlers: AddTaskResources.Handlers
    private let dataService: UserDefaultsServiceProtocol

    var newTask: TaskListTableViewCell.Model = .init()
    var taskIndex: Int?

    var onStateChange: ((AddTaskResources.State) -> Void)?

    // MARK: - Init
    init(context: AppContext, handlers: AddTaskResources.Handlers) {
        self.context = context
        self.handlers = handlers
        self.dataService = context.userDefaultsService
    }

    init(context: AppContext, handlers: AddTaskResources.Handlers, task: TaskListTableViewCell.Model, at index: Int) {
        self.context = context
        self.handlers = handlers
        self.dataService = context.userDefaultsService

        self.newTask = task
        self.taskIndex = index
    }

    // MARK: - Public methods
    func launch() {
        setupModels()
    }

    func didTapCancel() {
        handlers.onCancelTask()
    }

    func didTapDone() {
        self.addNewTaskToTheList()
        self.handlers.onDoneTask()
    }

    func didTapEdit() {
        self.editTask()
        self.handlers.onDoneTask()
    }

    func setTaskTitle(_ title: String?) {
        self.newTask.taskTitle = title
    }

    func setTaskDescription(_ description: String?) {
        if newTask.taskTitle == nil {
            newTask.taskTitle = Constants.newTaskMockTitle
            onStateChange?(.onEpmtyTitle(Constants.newTaskMockTitle))
        }
        self.newTask.taskDescription = description
    }
}

private extension AddTaskViewModel {
    // MARK: - Private methods
    func setupModels() {
        setupExistingTask()
    }

    func addNewTaskToTheList() {
        guard var allTasks: [TaskListTableViewCell.Model] = dataService.fetchOptional(for: Constants.allTasksUserDefaultsKey) else {
            var newTaskList: [TaskListTableViewCell.Model] = .init()
            newTaskList.append(newTask)
            dataService.put(for: Constants.allTasksUserDefaultsKey, value: newTaskList)
            return
        }

        allTasks.append(newTask)
        dataService.put(for: Constants.allTasksUserDefaultsKey, value: allTasks)
    }

    func setupExistingTask() {
        guard let allTasks: [TaskListTableViewCell.Model] = dataService.fetchOptional(for: Constants.allTasksUserDefaultsKey),
              let index = self.taskIndex
        else {
            return
        }

        let currentTask = allTasks[index]

        onStateChange?(.onSetTask(currentTask))
    }

    func editTask() {
        guard var allTasks: [TaskListTableViewCell.Model] = dataService.fetchOptional(for: Constants.allTasksUserDefaultsKey),
              let index = self.taskIndex
        else {
            return
        }

        allTasks[index] = newTask
        dataService.put(for: Constants.allTasksUserDefaultsKey, value: allTasks)
    }
}
