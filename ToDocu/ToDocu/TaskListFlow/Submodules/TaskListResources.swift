//
//  TaskListResources.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 13.07.23.
//

import UIKit

struct TaskListResources {
    // MARK: - Handlers
    struct Handlers {
        var onAddTask: () -> Void
        var onViewTask: (TaskListTableViewCell.Model, Int) -> Void
    }

    // MARK: - States
    enum State {
        case onTaskListTableView([TaskListTableViewCell.Model])
        case onReloadTableViewRow(Int, [TaskListTableViewCell.Model])
    }

    // MARK: - Constants
    enum Constants {
        enum UI {
            static let viewControllerTitle: String = "ToDocu ✅"
        }

        enum Mocks {
            static let allTasksUserDefaultsKey: String = "allTasks"
        }
    }
}
