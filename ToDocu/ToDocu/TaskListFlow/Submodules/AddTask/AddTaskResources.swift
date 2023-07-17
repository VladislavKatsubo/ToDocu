//
//  AddTaskResources.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 15.07.23.
//

import UIKit

struct AddTaskResources {
    // MARK: - Handlers
    struct Handlers {
        var onCancelTask: () -> Void
        var onDoneTask: () -> Void
    }

    // MARK: - States
    enum State {
        case onEpmtyTitle(String)
        case onSetTask(TaskListTableViewCell.Model)
    }

    // MARK: - Constants
    enum Constants {

        enum UI {
            static let taskInputViewOffset: CGFloat = 20.0
            static let taskInputViewInset: CGFloat = -20.0
        }

        enum Mocks {
            static let newTaskUserDefaultsKey: String = "newTask"
            static let allTasksUserDefaultsKey: String = "allTasks"
            static let newTaskMockTitle: String = "New Task"
        }
    }
}
