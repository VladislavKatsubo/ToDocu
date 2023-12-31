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
        static let taskTitleLabelFontColor: UIColor = .black
        static let secondaryLabelsFontColor: UIColor = .gray

        static let containerViewOffset: CGFloat = 10.0
        static let containerViewInset: CGFloat = -10.0

        static let containerViewCornerRadius: CGFloat = 20.0
        static let containerViewShadowRadius: CGFloat = 5.0
        static let containerViewShadowOpacity: Float = 0.3
        static let containerViewShadowOffset: CGSize = CGSize(width: 3.0, height: 3.0)

        static let verticalStackViewOffset: CGFloat = 20.0
        static let verticalStackViewInset: CGFloat = -20.0
        static let verticalStackViewSpacing: CGFloat = 10.0

        static let statusButtonViewOffset: CGFloat = 20.0
    }

    private let containerView = TView()
    private let statusButton = TaskStatusButtonView()
    private let verticalStackView = TStackView(axis: .vertical, spacing: Constants.verticalStackViewSpacing)
    private let taskTitleLabel = UILabel()
    private let taskDescriptionLabel = UILabel()

    var onTaskStatusTap: (() -> Void)?

    // MARK: - Public methods
    override func didLoad() {
        super.didLoad()
        setupItems()
    }

    // MARK: - Configure
    func configure(with model: Model?) {
        guard let model = model else { return }

        self.taskTitleLabel.text = model.taskTitle
        self.taskDescriptionLabel.text = model.taskDescription
        self.statusButton.taskStatus = model.status
        
        self.changeAppearance(for: model.status)
    }
}

private extension TaskListTableViewCell {
    // MARK: - Private methods
    func setupItems() {
        setupContainerView()
        setupTaskStatusButtonView()
        setupVerticalStackView()
        setupTaskTitleLabel()
        setupTaskDescriptionLabel()
    }

    func setupContainerView() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = Constants.containerViewCornerRadius
        containerView.layer.shadowRadius = Constants.containerViewShadowRadius
        containerView.layer.shadowOpacity = Constants.containerViewShadowOpacity
        containerView.layer.shadowOffset = Constants.containerViewShadowOffset

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.containerViewOffset),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.containerViewOffset),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.containerViewInset),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.containerViewInset),
        ])
    }


    func setupTaskStatusButtonView() {
        containerView.addSubview(statusButton)
        statusButton.translatesAutoresizingMaskIntoConstraints = false
        
        statusButton.onTap = { [weak self] in
            self?.onTaskStatusTap?()
        }

        NSLayoutConstraint.activate([
            statusButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.statusButtonViewOffset),
            statusButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.statusButtonViewOffset),
            statusButton.widthAnchor.constraint(equalToConstant: bounds.width / 10.0),
            statusButton.heightAnchor.constraint(equalTo: statusButton.widthAnchor, multiplier: 1.0)
        ])
    }

    func setupVerticalStackView() {
        containerView.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false

        verticalStackView.addArrangedSubview(taskTitleLabel)
        verticalStackView.addArrangedSubview(taskDescriptionLabel)

        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.verticalStackViewOffset),
            verticalStackView.leadingAnchor.constraint(equalTo: statusButton.trailingAnchor, constant: Constants.verticalStackViewOffset),
            verticalStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Constants.verticalStackViewInset),
            verticalStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: Constants.verticalStackViewInset),
//            verticalStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }

    func setupTaskTitleLabel() {
        taskTitleLabel.font = Constants.taskTitleLabelFont
        taskTitleLabel.textColor = Constants.taskTitleLabelFontColor
        taskTitleLabel.numberOfLines = 1
    }

    func setupTaskDescriptionLabel() {
        taskDescriptionLabel.font = Constants.descriptionLabelFont
        taskDescriptionLabel.textColor = Constants.secondaryLabelsFontColor
        taskDescriptionLabel.numberOfLines = 3
    }

    func changeAppearance(for status: TaskStatusButtonView.TaskStatus?) {
        switch status {
        case .done:
            self.taskTitleLabel.textColor = Constants.secondaryLabelsFontColor
        case .inProgress:
            self.taskTitleLabel.textColor = Constants.taskTitleLabelFontColor
        case .none:
            self.taskTitleLabel.textColor = Constants.taskTitleLabelFontColor
        }
    }
}

extension TaskListTableViewCell {
    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        statusButton.reset()
        taskTitleLabel.text = nil
        taskDescriptionLabel.text = nil
        self.changeAppearance(for: .none)
    }
}
