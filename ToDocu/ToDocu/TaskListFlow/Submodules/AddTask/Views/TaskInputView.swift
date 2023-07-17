//
//  TaskInputView.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 16.07.23.
//

import UIKit

final class TaskInputView: TView {

    private enum Constants {
        static let backgroundColor: UIColor = UIColor.white
        static let cornerRadius: CGFloat = 20.0

        static let titleTextFieldPlaceholder: String = "Title"
        static let descriptionTextFieldPlaceholder: String = "Description"

        static let textFieldOffest: CGFloat = 20.0
        static let textFieldInset: CGFloat = -20.0

        static let standardTextContainerInset: UIEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }

    private let titleTextView = TaskTextView()
    private let descriptionTextView = TaskTextView()

    var onTitleText: ((String?) -> Void)?
    var onDescriptionText: ((String?) -> Void)?

    // MARK: - Lifecycle
    override func didLoad() {
        setupItems()
    }

    func setMockTitle(with text: String?) {
        self.titleTextView.text = text
    }

    func setTask(with model: TaskListTableViewCell.Model) {
        self.titleTextView.text = model.taskTitle
        self.descriptionTextView.text = model.taskDescription
    }
}

private extension TaskInputView {
    // MARK: - Private methods
    func setupItems() {
        self.backgroundColor = Constants.backgroundColor
        self.layer.cornerRadius = Constants.cornerRadius

        setupTitleTextField()
        setupDescriptionTextField()
    }

    func setupTitleTextField() {
        addSubview(titleTextView)
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        titleTextView.configure(with: Constants.titleTextFieldPlaceholder)

        titleTextView.onText = { [weak self] text in
            self?.onTitleText?(text)
        }

        NSLayoutConstraint.activate([
            titleTextView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.textFieldOffest),
            titleTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.textFieldOffest),
            titleTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.textFieldInset),
            titleTextView.heightAnchor.constraint(equalToConstant: 100.0)
        ])
    }

    func setupDescriptionTextField() {
        addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.configure(with: Constants.descriptionTextFieldPlaceholder)

        descriptionTextView.onText = { [weak self] text in
            self?.onDescriptionText?(text)
        }

        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor),
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.textFieldOffest),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.textFieldInset),
            descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.textFieldInset),
            descriptionTextView.heightAnchor.constraint(equalTo: titleTextView.heightAnchor)
        ])
    }
}
