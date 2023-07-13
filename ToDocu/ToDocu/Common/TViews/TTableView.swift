//
//  TTableView.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 13.07.23.
//

import UIKit

class TTableView: UITableView {

    init(style: UITableView.Style) {
        super.init(frame: .zero, style: style)
        setupItems()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    func registerCells(_ cells: [TTableCell.Type]) {
        cells.forEach({ register($0, forCellReuseIdentifier: $0.reuseID) })
    }

    func registerHeadersFooters(_ headersFooters: [TTableSection.Type]) {
        headersFooters.forEach({ register($0, forHeaderFooterViewReuseIdentifier: $0.reuseID) })
    }
}

private extension TTableView {
    // MARK: - Private methods
    func setupItems() {
        backgroundColor = .clear
    }
}
