//
//  TTableSection.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 13.07.23.
//

import UIKit

class TTableSection: UITableViewHeaderFooterView {

    static var reuseID: String { String(describing: self) }

    // MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        didLoad()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemeted")
    }

    // MARK: - Public methods
    func didLoad() {

    }
}
