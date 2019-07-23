//
//  UIColorExtension.swift
//  ESSDynamicForm
//
//  Created by AIA-Chris on 16/07/19.
//  Copyright © 2019 chrizers. All rights reserved.
//

import UIKit

extension UIColor {
    /**
     * You can call this function easy from everywhare you want.
     * And put hex color string as a parameter
     * Example : #FFFFFF -> UIColor.white
     */
    internal static func hexStringToUIColor(hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        if (cString.count) != 6 {
            return UIColor.gray
        }
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    public class func secondaryPrimaryColor() -> UIColor {
        return hexStringToUIColor(hex: "#FF9900")
    }
}
