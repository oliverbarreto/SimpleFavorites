//
//  UIColor_Extension.swift
//  OnboardingWorkflow
//
//  Created by David Oliver Barreto Rodríguez on 24/12/16.
//  Copyright © 2016 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit



extension UIColor {

    //: Convinience init for RGB values
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    //: Convinience init for HEX values passing a HEX number in swift e.g. "0xFF"
    convenience init(hex0x:Int) {
        self.init(red:(hex0x >> 16) & 0xff, green:(hex0x >> 8) & 0xff, blue:hex0x & 0xff)
    }
    
    //: Convinience init for HEX values passing a string with, or without, the #: #FFFFFF, FFFFFF, #fafa11, FAFA11 are all valid
    convenience init(hex:String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            self.init()
            return
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0))
    }
    
    // Convenience methods that returns the hex value for a given UIColor instance
    var hexValue:String {
        return hexValue(withAlpha: false)
    }

    func hexValue(withAlpha alpha: Bool) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        if (alpha) {
            return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
        } else {
            return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
        }
    }
    
    
}
