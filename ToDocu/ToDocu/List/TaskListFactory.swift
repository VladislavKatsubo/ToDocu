//
//  TaskListFactory.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 13.07.23.
//

import UIKit

final class TaskListFactory {
    func makeViewController() -> UIViewController {
        let viewModel = TaskListViewModel()
        let viewController = TaskListViewController()

        viewController.configure(with: viewModel)

        return viewController
    }
}
