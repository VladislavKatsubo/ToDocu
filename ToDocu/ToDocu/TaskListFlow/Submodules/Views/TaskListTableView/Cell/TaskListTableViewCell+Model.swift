//
//  TaskListTableViewCell+Model.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 13.07.23.
//

import Foundation

extension TaskListTableViewCell {
    struct Model: Codable {
        var taskTitle: String? = nil
        var taskDescription: String? = nil
        var status: TaskStatusButtonView.TaskStatus = .inProgress
    }
}
