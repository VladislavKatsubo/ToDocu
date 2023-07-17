//
//  MainFlow.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 16.07.23.
//

import UIKit

final class MainFlow {
    private(set) var navigator: MainFlowNavigatorProtocol
    private var taskFlow: TaskListFlow?

    init(navigator: MainFlowNavigatorProtocol) {
        self.navigator = navigator
    }

    // MARK: - Public methods
    func makeStartFlow(window: UIWindow?) -> Bool {
        guard let window = window else { return false }

        window.rootViewController = makeTaskListFlow()
        window.makeKeyAndVisible()

        return true
    }
}

extension MainFlow {
    func makeTaskListFlow() -> UIViewController {
        taskFlow = TaskListFlow(navigator: TaskListFlowNavigator())
        guard let vc = taskFlow?.makeStartFlow() else {
            return .init()
        }

        return vc
    }
}
