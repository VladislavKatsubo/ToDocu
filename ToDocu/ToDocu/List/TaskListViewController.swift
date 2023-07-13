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

    private let tableView = TaskListTableView()

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
            case .onTaskListTableView(let models):
                self.tableView.configure(with: models)
            }
        }
        self.viewModel?.launch()
    }

    func setupItems() {
        view.backgroundColor = .systemBackground
        setupTableView()
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.onTap = { [weak self] task in
            self?.viewModel?.didTap(at: task)
        }

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
