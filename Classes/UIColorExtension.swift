//
//  UIColorExtension.swift
//  
//
//  Created by Famara Kassama on 01.04.19.
//

import Foundation

extension UIColor {

    /**
     Returns the color representation as hexadecimal string.
     
     - returns: A string similar to this pattern "#f4003b".
     */
    public final func toHexColorString() -> String {
        return String(format: "#%06x", toHexValue())
    }

    /**
     Returns the color representation as an integer.
     
     - returns: A UInt32 that represents the hexa-decimal color.
     */
    public final func toHexValue() -> UInt32 {
        func roundToHexValue(_ x: CGFloat) -> UInt32 {
            guard x > 0 else { return 0 }
            let rounded: CGFloat = round(x * 255)

            return UInt32(rounded)
        }

        let rgba       = toRGBAColorComponents()
        let colorToInt = roundToHexValue(rgba.r) << 16 | roundToHexValue(rgba.g) << 8 | roundToHexValue(rgba.b)

        return colorToInt
    }

    // MARK: - Getting the RGBA Components

    /**
     Returns the RGBA (red, green, blue, alpha) components.
     
     - returns: The RGBA components as a tuple (r, g, b, a).
     */
    public final func toRGBAColorComponents() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)

        return (r, g, b, a)
    }
}
