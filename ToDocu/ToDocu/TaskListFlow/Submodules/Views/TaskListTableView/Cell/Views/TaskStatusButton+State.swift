//
//  TaskStatusButton+State.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 13.07.23.
//

import UIKit

extension TaskStatusButtonView {
    enum TaskStatus: Codable {
        case done
        case inProgress

        var innerCircleColor: UIColor {
            switch self {
            case .done: return .systemGreen
            case .inProgress: return .clear
            }
        }

        var borderColor: UIColor {
            switch self {
            case .done: return .systemGreen
            case .inProgress: return .gray
            }
        }

        mutating func toggle() {
            if self == .done {
                self = .inProgress
            } else {
                self = .done
            }
        }
    }
}

