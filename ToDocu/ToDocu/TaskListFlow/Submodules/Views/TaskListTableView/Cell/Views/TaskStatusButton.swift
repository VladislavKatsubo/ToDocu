//
//  TaskStatusButton.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 13.07.23.
//

import UIKit

final class TaskStatusButtonView: TView {

    private enum Constants {

    }

    private let borderLayer = CAShapeLayer()
    private let innerCircleLayer = CAShapeLayer()
    private let button = TButton()

    var taskStatus: TaskStatus = .inProgress {
        didSet {
            self.borderLayer.strokeColor = taskStatus.borderColor.cgColor
            self.innerCircleLayer.fillColor = taskStatus.innerCircleColor.cgColor
        }
    }

    var onTap: (() -> Void)?

    // MARK: - Lifecycle
    override func didLoad() {
        super.didLoad()
        setupItems()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupBorderLayerPath()
        setupInnerCirclePath()
    }

    // MARK: - Public methods
    func reset() {
        taskStatus = .inProgress
    }
}

private extension TaskStatusButtonView {
    // MARK: - Private methods
    func setupItems() {
        setupButton()
        setupBorderLayerProperties()
        setupInnerCircleLayerProperties()
    }

    func setupBorderLayerPath() {
        let borderWidth = bounds.height / 10.0
        let path = UIBezierPath(
            arcCenter: .init(x: bounds.midX, y: bounds.midY),
            radius: bounds.height / 2,
            startAngle: .zero,
            endAngle: 2 * .pi,
            clockwise: true
        )
        self.borderLayer.path = path.cgPath
        borderLayer.lineWidth = borderWidth
    }

    func setupBorderLayerProperties() {
        borderLayer.strokeColor = taskStatus.borderColor.cgColor
        borderLayer.fillColor = taskStatus.innerCircleColor.cgColor
        layer.addSublayer(borderLayer)
    }

    func setupInnerCirclePath() {
        let borderWidth = bounds.height / 10.0
        let path = UIBezierPath(
            arcCenter: .init(x: bounds.midX, y: bounds.midY),
            radius: bounds.height / 2 - (borderWidth),
            startAngle: .zero,
            endAngle: 2 * .pi,
            clockwise: true
        )
        self.innerCircleLayer.path = path.cgPath
    }

    func setupInnerCircleLayerProperties() {
        innerCircleLayer.fillColor = taskStatus.innerCircleColor.cgColor
        layer.addSublayer(innerCircleLayer)
    }

    func setupButton() {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear

        button.onTap = { [weak self] in
            self?.onTap?()
        }

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
