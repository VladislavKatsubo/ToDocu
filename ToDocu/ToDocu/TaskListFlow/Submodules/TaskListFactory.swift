//
//  TaskListFactory.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 13.07.23.
//

import UIKit

final class TaskListFactory {
    func makeViewController(with handlers: TaskListResources.Handlers) -> UIViewController {
        let context: AppContext = AppDelegate.shared.context
        let viewModel = TaskListViewModel(context: context, handlers: handlers)
        let viewController = TaskListViewController()

        viewController.configure(with: viewModel)
        
        return viewController
    }
}
