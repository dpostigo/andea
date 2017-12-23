//
// Created by Daniela Postigo on 12/22/17.
//

import Foundation
import UIKit


extension UIVisualEffectView {
	public convenience init(blur style: UIBlurEffectStyle, alpha: CGFloat = 1.0) {
		self.init(effect: UIBlurEffect(style: style), alpha: alpha)
	}
	public convenience init(vibrancy style: UIBlurEffectStyle, alpha: CGFloat = 1.0) {
		self.init(effect: UIVibrancyEffect(style: style), alpha: alpha)
	}
}

extension UIVibrancyEffect {
	public convenience init(style: UIBlurEffectStyle) {
		self.init(blurEffect: UIBlurEffect(style: style))
	}
}

extension UIImageView {

	public convenience init(blur blurStyle: UIBlurEffectStyle?, vibrancy vibrancyStyle: UIBlurEffectStyle?) {
		self.init(frame: .zero, blur: blurStyle, vibrancy: vibrancyStyle)
	}

	public convenience init(frame: CGRect, blur blurStyle: UIBlurEffectStyle?, vibrancy vibrancyStyle: UIBlurEffectStyle?) {
		self.init(frame: frame)

		switch blurStyle {
			case .none: break
			case .some(let style): self.embed(UIVisualEffectView(blur: style), from: self.safeAreaLayoutGuide)
		}

		switch vibrancyStyle {
			case .none: break
			case .some(let style): self.embed(UIVisualEffectView(vibrancy: style), from: self.safeAreaLayoutGuide)
		}
	}
}


extension UIBlurEffectStyle {

	public static var all: [UIBlurEffectStyle] {
		return [.extraLight, .light, .dark, .regular, .prominent]
	}

	public var stringValue: String {
		switch self {
			case .extraLight: return "extraLight"
			case .light: return "light"
			case .dark: return "dark"
			case .regular: return "regular"
			case .prominent: return "prominent"
			default: return ""
		}
	}
}

