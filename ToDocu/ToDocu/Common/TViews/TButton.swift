//
//  TButton.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 13.07.23.
//

import UIKit

class TButton: UIButton {

    var onTap: (() -> Void)?

    // MARK: - Init
    init() {
        super.init(frame: .zero)
        didLoad()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    func didLoad() {
        imageView?.contentMode = .scaleAspectFit
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
}

private extension TButton {
    @objc
    func didTap() {
        onTap?()
    }
}
