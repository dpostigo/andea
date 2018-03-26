//
// Created by Daniela Postigo on 1/6/18.
//

import Foundation
import UIKit

open class PlaygroundTableHeaderFooterView: UITableViewHeaderFooterView {
	override open var textLabel: UILabel? { return self.title }
	override open var detailTextLabel: UILabel? { return self.subtitle }
	public var imageView = UIImageView(image: nil, cornerRadius: 4.0)

	public var customView = UIView() {
		didSet { self.update() }
	}
	open var footerView: UIView = PlaygroundTableFooterView() {
		didSet { self.update() }
	}

	private let title = UILabel(title: Lorem.word)
	private let subtitle = UILabel(title: Lorem.emailAddress)

	// MARK: Init

	public required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override public init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)

		self.contentView.layoutMargins = [30, 20]
		self.tintColor = .white
		self.backgroundView = UIView(color: .black)

		self.footerView.borderColor = .darkGray
		self.contentView.borderColor = .darkGray
		self.customView.isHidden = true

		self.title.textAlignment = .center
		self.title.verticalContentHuggingPriority = .required
		self.subtitle.textAlignment = .center

		self.imageView.backgroundColor = .init(white: 1.0, alpha: 0.1)

		self.setupConstraints()

	}
	open override func tintColorDidChange() {
		super.tintColorDidChange()

		self.title.textColor = self.tintColor
		self.subtitle.textColor = self.tintColor
	}

	private func update() {
		self.contentView.removeAllSubviews()
		self.setupConstraints()
	}

	private func setupConstraints() {
		let stack = UIStackView(
			axis: .vertical,
			spacing: 0,
			alignment: .center,
			distribution: .fillProportionally,
			views: [self.title, self.subtitle, self.customView]
		)

		self.contentView.addView(self.imageView)
		self.contentView.addView(stack)
		self.contentView.addView(self.footerView)

		let guides = (
			margins: self.contentView.layoutMarginsGuide,
			root: self.contentView.safeAreaLayoutGuide,
			stack: stack.safeAreaLayoutGuide,
			footer: self.footerView.safeAreaLayoutGuide,
			imageView: self.imageView.safeAreaLayoutGuide
		)

		NSLayoutConstraint.activate(
			// guides.imageView.topAnchor.constraint(equalTo: guides.margins.topAnchor).priority(999),
			guides.imageView.topAnchor.constraint(equalTo: guides.margins.topAnchor),
			guides.imageView.centerXAnchor.constraint(equalTo: guides.margins.centerXAnchor),
			guides.imageView.widthAnchor.constraint(equalTo: guides.margins.widthAnchor, multiplier: 0.3),
			guides.imageView.heightAnchor.constraint(equalTo: guides.imageView.widthAnchor),
			guides.stack.topAnchor.constraint(equalTo: guides.imageView.bottomAnchor, constant: 15),
			guides.stack.leadingAnchor.constraint(equalTo: guides.margins.leadingAnchor),
			guides.stack.trailingAnchor.constraint(equalTo: guides.margins.trailingAnchor),
			// guides.stack.bottomAnchor.constraint(equalTo: guides.margins.bottomAnchor),
			guides.footer.topAnchor.constraint(equalTo: guides.stack.bottomAnchor, constant: 20),
			guides.footer.leadingAnchor.constraint(equalTo: guides.root.leadingAnchor),
			guides.footer.trailingAnchor.constraint(equalTo: guides.root.trailingAnchor),
			guides.footer.bottomAnchor.constraint(equalTo: guides.root.bottomAnchor)
		)
	}
}

