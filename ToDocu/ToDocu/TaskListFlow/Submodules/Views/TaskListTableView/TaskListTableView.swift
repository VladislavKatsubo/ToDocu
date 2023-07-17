//
//  TaskListTableView.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 13.07.23.
//

import UIKit

final class TaskListTableView: TView {

    private enum Constants {

    }

    private let tableView = TTableView(style: .plain)

    private var models: [TaskListTableViewCell.Model] = []

    var onTap: ((Int) -> Void)?
    var onTaskStatusTap: ((Int) -> Void)?
    var onDeleteTask: ((Int) -> Void)?

    // MARK: - Public methods
    override func didLoad() {
        super.didLoad()
        setupTableView()
    }

    // MARK: - Configure
    func configure(with models: [TaskListTableViewCell.Model]) {
        self.models = models
        self.tableView.reloadData()
    }

    // MARK: - Public methods
    func reloadRow(at index: Int, with models: [TaskListTableViewCell.Model]) {
        self.models = models
        let indexPath = IndexPath(row: index, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: .none)
    }
}

private extension TaskListTableView {
    // MARK: - Private methods
    func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.registerCells([TaskListTableViewCell.self])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension TaskListTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TaskListTableViewCell.reuseID,
            for: indexPath
        ) as? TaskListTableViewCell else {
            return .init()
        }

        let model = models[safe: indexPath.row]
        cell.configure(with: model)

        cell.onTaskStatusTap = { [weak self] in
            self?.onTaskStatusTap?(indexPath.row)
        }

        return cell
    }
}

extension TaskListTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onTap?(indexPath.row)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            self?.models.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .automatic)

            completionHandler(true)
            self?.onDeleteTask?(indexPath.row)
        }

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])

        return configuration
    }
}
