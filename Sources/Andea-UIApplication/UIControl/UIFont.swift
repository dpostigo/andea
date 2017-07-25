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
    
}
