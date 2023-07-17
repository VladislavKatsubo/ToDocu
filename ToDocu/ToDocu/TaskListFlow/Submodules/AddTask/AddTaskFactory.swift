//
//  AddTaskFactory.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 15.07.23.
//

import UIKit

final class AddTaskFactory {
    func createController(handlers: AddTaskResources.Handlers) -> UIViewController {
        let context: AppContext = AppDelegate.shared.context
        let viewModel = AddTaskViewModel(context: context, handlers: handlers)
        let viewController = AddTaskViewController()

        viewController.configure(viewModel: viewModel)

        return viewController
    }

    func createController(handlers: AddTaskResources.Handlers, with task: TaskListTableViewCell.Model, at index: Int) -> UIViewController {
        let context: AppContext = AppDelegate.shared.context
        let viewModel = AddTaskViewModel(context: context, handlers: handlers, task: task, at: index)
        let viewController = AddTaskViewController()

        viewController.configure(viewModel: viewModel)

        return viewController
    }
}
