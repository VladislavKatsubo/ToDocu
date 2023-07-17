//
//  TaskListFlow.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 15.07.23.
//

import UIKit

protocol TaskListFlowProtocol {

}

final class TaskListFlow: TaskListFlowProtocol {

    private let navigator: TaskListFlowNavigatorProtocol

    // MARK: - Init
    init(navigator: TaskListFlowNavigatorProtocol) {
        self.navigator = navigator
    }

    // MARK: - Public methods
    func makeStartFlow() -> UIViewController {
        let handlers = TaskListResources.Handlers(
            onAddTask: { [weak self] in
                guard let self = self else { return }

                let viewController = self.makeAddTaskViewController()
                self.navigator.push(viewController, animated: true, completion: nil)
            },
            onViewTask: { [weak self] task, index in
                guard let self = self else { return }
                let viewController = self.makeAddTaskViewController(with: task, at: index)
                self.navigator.push(viewController, animated: true, completion: nil)
            }
        )

        let vc = TaskListFactory().makeViewController(with: handlers)
        return UINavigationController(rootViewController: vc)
    }
}

private extension TaskListFlow {
    // MARK: - Private methods
    func makeAddTaskViewController() -> UIViewController {
        let handlers = AddTaskResources.Handlers(
            onCancelTask: { [weak self] in
                self?.navigator.pop(animated: true, completion: nil)
            }, onDoneTask: { [weak self] in
                self?.navigator.pop(animated: true, completion: nil)
            })
        let vc = AddTaskFactory().createController(handlers: handlers)
        return vc
    }

    func makeAddTaskViewController(with task: TaskListTableViewCell.Model, at index: Int) -> UIViewController {
        let handlers = AddTaskResources.Handlers(
            onCancelTask: { [weak self] in
                self?.navigator.pop(animated: true, completion: nil)
            }, onDoneTask: { [weak self] in
                self?.navigator.pop(animated: true, completion: nil)
            })
        let vc = AddTaskFactory().createController(handlers: handlers, with: task, at: index)
        return vc
    }
}
