//
// Created by Dani Postigo on 11/28/16.
//

import Foundation
import UIKit

extension UIFont {
    public static func listAll() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            Swift.print("------------------------------")
            Swift.print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName )
            Swift.print("Font Names = [\(names)]")
        }
    }

	public var small: UIFont { return UIFont(name: self.fontName, size: UIFont.smallSystemFontSize)! }

	public var point10: UIFont { return self.point(10) }
	public func point(_ size: CGFloat) -> UIFont { return UIFont(name: self.fontName, size: size)! }


	public class var point10: UIFont { return UIFont.systemFont(ofSize: 10) }
	public class var small: UIFont { return UIFont.systemFont(ofSize: UIFont.smallSystemFontSize) }
	public class var system: UIFont { return UIFont.systemFont(ofSize: UIFont.systemFontSize) }
	public class var ultraLight: UIFont { return UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .ultraLight) }
	public class var thin: UIFont { return UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .thin) }
	public class var light: UIFont { return UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .light) }
	public class var medium: UIFont { return UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .medium)}
	public class var semibold: UIFont { return UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .semibold) }
	public class var bold: UIFont { return UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .bold)}
	public class var heavy: UIFont { return UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .heavy)}
	public class var black: UIFont { return UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .black)}

}


extension UIFont {

	open class var largeTitle: UIFont { return UIFont.preferredFont(forTextStyle: .largeTitle) }
	open class var title1: UIFont { return UIFont.preferredFont(forTextStyle: .title1) }
	open class var title2: UIFont { return UIFont.preferredFont(forTextStyle: .title2) }
	open class var title3: UIFont { return UIFont.preferredFont(forTextStyle: .title3) }
	open class var headline: UIFont { return UIFont.preferredFont(forTextStyle: .headline) }
	open class var subheadline: UIFont { return UIFont.preferredFont(forTextStyle: .subheadline) }

	open class var body: UIFont { return UIFont.preferredFont(forTextStyle: .body) }
	open class var callout: UIFont { return UIFont.preferredFont(forTextStyle: .callout) }
	open class var footnote: UIFont { return UIFont.preferredFont(forTextStyle: .footnote) }
	open class var caption1: UIFont { return UIFont.preferredFont(forTextStyle: .caption1) }
	open class var caption2: UIFont { return UIFont.preferredFont(forTextStyle: .caption2) }

}


extension UIFont {
	public class var damascus: UIFont.Family { return Family.damascus }
	public class var helveticaNeue: UIFont.Family { return Family.helveticaNeue }
}

extension UIFont {

	public enum Family: String {
		case damascus
		case helveticaNeue

		var name: String { return self.rawValue.capitalizedFirst }

		// MARK: Size

		public var small: UIFont {
			return self.font(.none).small
		}

		// MARK: Styles

		public var regular: UIFont { return self.font() }
		public var light: UIFont { return self.font(.light) }
		public var medium: UIFont { return self.font(.medium) }
		public var bold: UIFont { return self.font(.bold) }

		private func font(_ style: UIFont.Style = .none, size: CGFloat = UIFont.systemFontSize) -> UIFont {

            let name = self.name(style)
			Swift.print("name = \(String(describing: name))")
            
			return UIFont(name: self.name(style), size: size)!
		}

		// MARK: Private

		private func name(_ style: UIFont.Style) -> String {
			return style == .none ? self.name : (self.name + self.dash + style.name)
		}

		private var dash: String {
			return self.isDashed ? "-" : ""
		}

		private var isDashed: Bool {
			switch self {
				case .damascus : return false
				case .helveticaNeue : return true
			}
		}
	}
}


extension UIFont {
	public enum Style: String {
		case none = ""
		case light
		case medium
		case semibold = "semiBold"
		case bold

		var name: String {
			return self.rawValue.capitalizedFirst
		}
	}
}


extension UIFontTextStyle {

	public static var all: [UIFontTextStyle] {
		return [
			.largeTitle,
			.title1,
			.title2,
			.title3,
			.headline,
			.subheadline,
			.body,
			.callout,
			.footnote,
			.caption1,
			.caption2,
		]
	}
}
