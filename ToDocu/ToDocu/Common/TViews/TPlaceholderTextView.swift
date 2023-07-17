//
//  TPlaceholderTextView.swift
//  ToDocu
//
//  Created by Vlad Katsubo on 17.07.23.
//

import UIKit

class TPlaceholderTextView: UITextView {
    // MARK: - Constants
    private enum Constants {
        static let defaultPlaceholderColor: UIColor = .black
        static let defaultPlaceholderText: String = ""

        static let widthMultiplierPlaceholderLabel: CGFloat = 2.0
        static let numberOfLinesPlaceholderLabel: Int = 0
        static let backgroundColorPlaceholderLabel: UIColor = UIColor.clear
    }

    // MARK: - Private properties
    private let placeholderLabel: UILabel = UILabel()

    // MARK: - Public properties
    var placeholder: String = Constants.defaultPlaceholderText {
        didSet {
            placeholderLabel.text = placeholder
        }
    }

    var placeholderColor: UIColor? = Constants.defaultPlaceholderColor {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }

    var placeholderFont: UIFont? {
        didSet {
            let font = (placeholderFont != nil) ? placeholderFont : self.font
            placeholderLabel.font = font
        }
    }

    override var font: UIFont? {
        didSet {
            if placeholderFont == nil {
                placeholderLabel.font = font
            }
        }
    }

    override open var textAlignment: NSTextAlignment {
        didSet {
            placeholderLabel.textAlignment = textAlignment
        }
    }

    override open var text: String! {
        didSet {
            textDidChange()
        }
    }

    override open var attributedText: NSAttributedString! {
        didSet {
            textDidChange()
        }
    }

    override open var textContainerInset: UIEdgeInsets {
        didSet {
            updateConstraintsForPlaceholderLabel()
        }
    }

    // MARK: - Initi
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupPlaceholder()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupPlaceholder()
    }

    deinit {
        let notificationName = UITextView.textDidChangeNotification
        NotificationCenter.default.removeObserver(self, name: notificationName, object: nil)
    }

    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.preferredMaxLayoutWidth = textContainer.size.width - textContainer.lineFragmentPadding * Constants.widthMultiplierPlaceholderLabel
    }
}

private extension TPlaceholderTextView {
    // MARK: - Private methods
    func setupPlaceholder() {
        let notificationName = UITextView.textDidChangeNotification
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: notificationName, object: nil)

        placeholderLabel.font = font
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.textAlignment = textAlignment
        placeholderLabel.text = placeholder
        placeholderLabel.numberOfLines = Constants.numberOfLinesPlaceholderLabel
        placeholderLabel.backgroundColor = Constants.backgroundColorPlaceholderLabel
        addSubview(placeholderLabel)
        updateConstraintsForPlaceholderLabel()
    }

    func updateConstraintsForPlaceholderLabel() {
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: textContainerInset.top),
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textContainerInset.left + textContainer.lineFragmentPadding),
            placeholderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -textContainerInset.right - textContainer.lineFragmentPadding),
            placeholderLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -textContainerInset.bottom),
        ])
    }

    @objc func textDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
}
