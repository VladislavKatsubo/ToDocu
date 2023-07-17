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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.viewModel?.reloadModels()
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
            case .onReloadTableViewRow(let index, let currentTasks):
                self.tableView.reloadRow(at: index, with: currentTasks)
            }
        }
        self.viewModel?.launch()
    }

    func setupItems() {
        view.backgroundColor = .systemBackground

        setupTableView()
        setupNavBar()
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.onTap = { [weak self] index in
            self?.viewModel?.didTapCell(at: index)
        }
        tableView.onTaskStatusTap = { [weak self] index in
            self?.viewModel?.didTapTaskStatus(at: index)
        }
        tableView.onDeleteTask = { [weak self] index in
            self?.viewModel?.didSwipeToDeleteTask(at: index)
        }

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    func setupNavBar() {
        self.navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        self.title = Constants.viewControllerTitle
    }

    @objc
    func addTask() {
        self.viewModel?.didTapAddTaskButton()
    }
}
