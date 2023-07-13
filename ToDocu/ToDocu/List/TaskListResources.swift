//
//  TaskListResources.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 13.07.23.
//

import UIKit

struct TaskListResources {
    // MARK: - States
    enum State {
        case onTaskListTableView([TaskListTableViewCell.Model])
    }

    // MARK: - Constants
    enum Constants {
        enum UI {
        }

        enum Mocks {
            static let mockCells: [TaskListTableViewCell.Model] = [
                .init(
                    taskTitle: "Fuck them all!",
                    taskDescription: "Yebash!",
                    dueDate: .now
                ),
                .init(
                    taskTitle: "Fuck them all!",
                    taskDescription: "Yebash!",
                    dueDate: .now
                ),
                .init(
                    taskTitle: "Fuck them all!",
                    taskDescription: "Yebash!",
                    dueDate: .now
                ),
                .init(
                    taskTitle: "Fuck them all!",
                    taskDescription: "Yebash!",
                    dueDate: .now
                ),
                .init(
                    taskTitle: "Fuck them all!",
                    taskDescription: "Yebash!",
                    dueDate: .now
                ),
                .init(
                    taskTitle: "Fuck them all!",
                    taskDescription: "Yebash!",
                    dueDate: .now
                )                
            ]
        }
    }
}
