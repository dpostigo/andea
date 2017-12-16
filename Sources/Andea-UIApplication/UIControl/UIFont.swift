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
