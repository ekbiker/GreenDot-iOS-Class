//
//  Colors.swift
//  GD Lunch
//
//  Created by Ted Liao on 4/16/17.
//  Copyright © 2017 Ted Liao. All rights reserved.
//

import Foundation
import UIKit

fileprivate extension String {
    var length: Int {get {return characters.count}}
}

public extension UIColor {
    
    private static func colorComponentFromString(_ string: String, start: Int, length: Int) -> CGFloat {
        let substring = (string as NSString).substring(with: NSMakeRange(start, length))
        let fullHex = length==2 ? substring : substring+substring
        var num: UInt32 = 0
        Scanner(string: fullHex).scanHexInt32(&num)
        return CGFloat(Float32(num)/255.0)
    }
    
    private static func hexStringFromInt(_ n: Int) -> String {
        return NSString(format: "%02x", n) as String
    }
    
    public convenience init (hex: String) {
        let string = hex.replacingOccurrences(of: "#", with: "").uppercased()
        var alpha: CGFloat = 0
        var red: CGFloat = 0
        var blue: CGFloat = 0
        var green: CGFloat = 0
        
        switch (string.length) {
        case 3: // #RGB
            alpha = 1.0
            red   = UIColor.colorComponentFromString(string, start:0, length:1)
            green = UIColor.colorComponentFromString(string, start:1, length:1)
            blue  = UIColor.colorComponentFromString(string, start:2, length:1)
            break
            
        case 4: // #ARGB
            alpha = UIColor.colorComponentFromString(string, start:0, length:1)
            red   = UIColor.colorComponentFromString(string, start:1, length:1)
            green = UIColor.colorComponentFromString(string, start:2, length:1)
            blue  = UIColor.colorComponentFromString(string, start:3, length:1)
            break
            
        case 6: // #RRGGBB
            alpha = 1.0
            red   = UIColor.colorComponentFromString(string, start:0, length:2)
            green = UIColor.colorComponentFromString(string, start:2, length:2)
            blue  = UIColor.colorComponentFromString(string, start:4, length:2)
            break
            
        case 8: // #RRGGBBAA
            red =   UIColor.colorComponentFromString(string, start:0, length:2)
            green = UIColor.colorComponentFromString(string, start:2, length:2)
            blue =  UIColor.colorComponentFromString(string, start:4, length:2)
            alpha = UIColor.colorComponentFromString(string, start:6, length:2)
            break
            
        default:
            NSException.raise(
                NSExceptionName(rawValue: "Invalid color value"),
                format: "Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB",
                arguments: getVaList([hex])
            )
            break;
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    public static func randomColor() -> UIColor {
        let range: CGFloat = 256
        let r = CGFloat(arc4random_uniform(UInt32(range)))
        let g = CGFloat(arc4random_uniform(UInt32(range)))
        let b = CGFloat(arc4random_uniform(UInt32(range)))
        return UIColor(red:r/255.0, green:g/255.0, blue:b/255.0, alpha:1.0)
    }    
}


