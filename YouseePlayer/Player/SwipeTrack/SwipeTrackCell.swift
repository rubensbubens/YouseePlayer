//
//  SwipeTrackCell.swift
//  YouseePlayer
//
//  Created by Serhii Bazarnyi on 21.10.22.
//

import Foundation
import UIKit

class SwipeTrackCell: UICollectionViewCell {
    private let contentStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private

private extension SwipeTrackCell {
    func setup() {
        contentView.addSubview(contentStackView)

        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.topAnchor.constraint(equalTo: topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        contentStackView.spacing = 0
        contentStackView.axis = .vertical
    }
}

// MARK: - Public

extension SwipeTrackCell {
    func update(with view: UIView) {
        contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        contentStackView.addArrangedSubview(view)
    }
}

extension SwipeTrackCell {
    static let id = SwipeTrackCell.description()
}
