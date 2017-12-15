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


    public class var bold: UIFont { return self.bold(UIFont.systemFontSize) }
    public class var boldSmall: UIFont { return self.bold(UIFont.smallSystemFontSize) }

    public class func bold(_ size: CGFloat) -> UIFont { return UIFont.boldSystemFont(ofSize: size) }


    public class var size10: UIFont { return UIFont.systemFont(ofSize: 10.0) }
    public class var small: UIFont       { return UIFont.systemFont(ofSize: UIFont.smallSystemFontSize) }
}
