//
//  TaskListTableViewCell.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 13.07.23.
//

import UIKit

final class TaskListTableViewCell: TTableCell {

    private enum Constants {
        static let taskTitleLabelFont: UIFont = .systemFont(ofSize: 18.0, weight: .semibold)
        static let descriptionLabelFont: UIFont = .systemFont(ofSize: 16.0, weight: .regular)
        static let dueDateLabelFont: UIFont = .systemFont(ofSize: 14.0, weight: .thin)
        static let labelFontColor: UIColor = .black

        static let containerViewOffset: CGFloat = 20.0
        static let containerViewInset: CGFloat = -20.0

        static let containerViewCornerRadius: CGFloat = 20.0

        static let spacingAfterTaskDescriptionLabel: CGFloat = 30.0
    }

    private let containerView = TView()
    private let verticalStackView = TStackView(axis: .vertical)
    private let taskTitleLabel = UILabel()
    private let taskDescriptionLabel = UILabel()
    private let taskDueDateLabel = UILabel()

    // MARK: - Public methods
    override func didLoad() {
        super.didLoad()
        setupItems()
    }

    // MARK: - Configure
    func configure(with model: Model?) {
        self.taskTitleLabel.text = model?.taskTitle
        self.taskDescriptionLabel.text = model?.taskDescription
        self.taskDueDateLabel.text = "24.07.1996 08:00"
    }
}

private extension TaskListTableViewCell {
    // MARK: - Private methods
    func setupItems() {
        setupContainerView()
        setupVerticalStackView()
        setupTaskTitleLabel()
        setupTaskDescriptionLabel()
        setupTaskDueDateLabel()
    }

    func setupContainerView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = Constants.containerViewCornerRadius

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.containerViewOffset),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.containerViewOffset),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.containerViewInset),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.containerViewInset),
        ])
    }

    func setupVerticalStackView() {
        containerView.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false

        verticalStackView.addArrangedSubview(taskTitleLabel)
        verticalStackView.addArrangedSubview(taskDescriptionLabel)
        verticalStackView.setCustomSpacing(Constants.spacingAfterTaskDescriptionLabel, after: taskDescriptionLabel)
        verticalStackView.addArrangedSubview(taskDueDateLabel)

        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }

    func setupTaskTitleLabel() {
        taskTitleLabel.font = Constants.taskTitleLabelFont
        taskTitleLabel.textColor = Constants.labelFontColor
    }

    func setupTaskDescriptionLabel() {
        taskDescriptionLabel.font = Constants.descriptionLabelFont
        taskDescriptionLabel.textColor = Constants.labelFontColor

        taskDescriptionLabel.numberOfLines = 3
    }

    func setupTaskDueDateLabel() {
        taskDueDateLabel.font = Constants.dueDateLabelFont
        taskDueDateLabel.textColor = Constants.labelFontColor
    }
}
