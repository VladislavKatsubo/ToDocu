//
//  TaskTextField.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 16.07.23.
//

import UIKit

final class TaskTextView: TPlaceholderTextView {

    // MARK: - Constants
    private enum Constants {
        static let placeholder: String = ""
        static let placeholderFont: UIFont = .systemFont(ofSize: 18.0, weight: .regular)

        static let inputFont: UIFont = .systemFont(ofSize: 20.0, weight: .regular)
        static let textColor: UIColor = .black
        static let textAlignment: NSTextAlignment = .left
        static let placeholderColor: UIColor = .gray
    }

    var onText: ((String?) -> Void)?

    // MARK: - Configure
    func configure(with placeholderText: String) {
        placeholder = placeholderText
        didLoad()
    }

    // MARK: - Public methods
    func didLoad() {
        setupTextViewProperties()
    }
}

private extension TaskTextView {
    // MARK: - Private methods
    func setupTextViewProperties() {
        delegate = self
        isEditable = true
        isScrollEnabled = true
        textColor = .black
        textAlignment = .left
        font = Constants.inputFont

        placeholderColor = Constants.placeholderColor
        placeholderFont = Constants.placeholderFont
    }
}

// MARK: - TextViewDelegate
extension TaskTextView: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        onText?(textView.text)
    }
}
