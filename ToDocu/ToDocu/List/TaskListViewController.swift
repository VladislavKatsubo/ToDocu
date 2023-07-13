//
//  TaskListViewController.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 13.07.23.
//

import UIKit

final class TaskListViewController: UIViewController {

    typealias Constants = TaskListResources.Constants.UI
    typealias Mocks = TaskListResources.Constants.Mocks

    private var viewModel: TaskListViewModelProtocol?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
        setupViewModel()
    }

    // MARK: - Configure
    func configure(with viewModel: TaskListViewModelProtocol) {
        self.viewModel = viewModel
    }
}

private extension TaskListViewController {
    // MARK: - Private methods
    func setupViewModel() {
        self.viewModel?.onStateChange = { [weak self] state in
            guard let self = self else { return }

            switch state {

            }
        }
        self.viewModel?.launch()
    }

    func setupItems() {

    }
}
