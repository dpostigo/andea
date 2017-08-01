//
// Created by Daniela Postigo on 6/27/17.
//

import Foundation
import AppKit


extension NSColor {
    public var data: Data { return NSKeyedArchiver.archivedData(withRootObject: self) }

//    open convenience init?(data: Data) {
//        self.init?(coder: NSKeyedUnarchiver(forReadingWith: data ))
//    }
}
/**
    NSColor extension that add a whole bunch of utility functions like:
    - HTML/CSS RGB format conversion (i.e. 0x124672)
    - lighter color
    - darker color
    - color with modified brightness
 */
extension NSColor {
    /**
        Construct a NSColor using an HTML/CSS RGB formatted value and an alpha value

        :param: rgbValue RGB value
        :param: alpha color alpha value

        :returns: an NSColor instance that represent the required color
     */
    public class func colorWithRGB(rgbValue : UInt, alpha : CGFloat = 1.0) -> NSColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255
        let green = CGFloat((rgbValue & 0xFF00) >> 8) / 255
        let blue = CGFloat(rgbValue & 0xFF) / 255

        return NSColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    /**
        Returns a lighter color by the provided percentage

        :param: lighting percent percentage
        :returns: lighter NSColor
     */
    public func lighterColor(percent : Double) -> NSColor {
        return colorWithBrightnessFactor(factor: CGFloat(1 + percent));
    }

    /**
        Returns a darker color by the provided percentage

        :param: darking percent percentage
        :returns: darker NSColor
    */
    public func darken(_ percent : Double) -> NSColor {
        return colorWithBrightnessFactor(factor: CGFloat(1 - percent));
    }

    /**
        Return a modified color using the brightness factor provided

        :param: factor brightness factor
        :returns: modified color
    */
    public func colorWithBrightnessFactor(factor: CGFloat) -> NSColor {
        var hue : CGFloat = 0
        var saturation : CGFloat = 0
        var brightness : CGFloat = 0
        var alpha : CGFloat = 0


        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return NSColor(hue: hue, saturation: saturation, brightness: brightness * factor, alpha: alpha)

//            if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
//            return NSColor(hue: hue, saturation: saturation, brightness: brightness * factor, alpha: alpha)
//        } else {
//            return self;
//        }
    }
}
