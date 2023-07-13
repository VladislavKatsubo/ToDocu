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

    var onTap: ((TaskListTableViewCell.Model) -> Void)?

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

        return cell
    }
}

extension TaskListTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = models[safe: indexPath.row] else { return }

        onTap?(model)
    }
}
