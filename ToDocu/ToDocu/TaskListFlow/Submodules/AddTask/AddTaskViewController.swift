//
//  AddTaskViewController.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 15.07.23.
//

import UIKit

final class AddTaskViewController: UIViewController {

    typealias Constants = AddTaskResources.Constants.UI

    private let taskInputView = TaskInputView()

    private var viewModel: AddTaskViewModelProtocol?

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
        setupViewModel()
    }

    // MARK: - Configure
    func configure(viewModel: AddTaskViewModelProtocol) {
        self.viewModel = viewModel
    }
}

private extension AddTaskViewController {
    // MARK: - Private methods
    func setupViewModel() {
        viewModel?.onStateChange = { [weak self] state in
            guard let self = self else { return }

            switch state {
            case .onEpmtyTitle(let mockTitle):
                self.taskInputView.setMockTitle(with: mockTitle)
            case .onSetTask(let model):
                self.setupEditButton()
                self.taskInputView.setTask(with: model)
            }
        }
        viewModel?.launch()
    }

    func setupItems() {
        view.backgroundColor = .secondarySystemBackground

        setupInputView()
        setupNavigationContoller()
        setupTapGesture()
    }

    func setupInputView() {
        view.addSubview(taskInputView)
        taskInputView.translatesAutoresizingMaskIntoConstraints = false
        taskInputView.onTitleText = { [weak self] title in
            self?.viewModel?.setTaskTitle(title)
            self?.navigationItem.rightBarButtonItem?.isEnabled = true
        }

        taskInputView.onDescriptionText = { [weak self] description in
            self?.viewModel?.setTaskDescription(description)
            self?.navigationItem.rightBarButtonItem?.isEnabled = true
        }

        NSLayoutConstraint.activate([
            taskInputView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.taskInputViewOffset),
            taskInputView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.taskInputViewOffset),
            taskInputView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.taskInputViewInset),
            taskInputView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

private extension AddTaskViewController {
    // MARK: - NavBar Items' methods
    func setupNavigationContoller() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelNewTask))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneNewTask))
        doneButton.isEnabled = false

        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = doneButton

        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }

    @objc
    func cancelNewTask() {
        self.viewModel?.didTapCancel()
    }

    @objc
    func doneNewTask() {
        self.viewModel?.didTapDone()
    }

    func setupEditButton() {
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editExistingTask))
        self.navigationItem.rightBarButtonItem = editButton
    }

    @objc
    func editExistingTask() {
        self.viewModel?.didTapEdit()
    }
}

// MARK: - Dismiss keyboard when tapped outside of the input area
private extension AddTaskViewController {
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
