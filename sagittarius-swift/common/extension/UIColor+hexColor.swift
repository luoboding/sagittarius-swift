//
//  UIColor+hexColor.swift
//  sagittarius-swift
//
//  Created by bonedeng on 4/16/16.
//  Copyright © 2016 xingdongyou. All rights reserved.
//

import UIKit

public extension UIColor {
    convenience init(hexString: String) {
        self.init(hexString: hexString, alpha: 1.0)!
    }
    
    public convenience init?(hexString: String, alpha: Float) {
        var hex = hexString
        if hex.hasPrefix("#") {
            hex = hex.substringFromIndex(hex.startIndex.advancedBy(1))
        }
        
        
        if hex.rangeOfString("(^[0-9A-Fa-f]{6})$|(^0-9A-Fa-f{3}$)", options: .RegularExpressionSearch) != nil {
            
            if hex.characters.count == 3 {
                let redHex = hex.substringToIndex(hex.startIndex.advancedBy(1))
                
                let greenHex = hex.substringWithRange(Range<String.Index>(hex.startIndex.advancedBy(1) ..< hex.startIndex.advancedBy(2)))
                
                let bludHex = hex.substringFromIndex(hex.startIndex.advancedBy(2))
                hex = redHex + redHex + greenHex + greenHex + bludHex + bludHex
            }
            
            let redHex = hex.substringToIndex(hex.startIndex.advancedBy(2))
            
            let greenHex = hex.substringWithRange(Range<String.Index>(hex.startIndex.advancedBy(2) ..< hex.startIndex.advancedBy(4)))
            
            let blueHex = hex.substringFromIndex(hex.startIndex.advancedBy(4))
            
            var redInt: CUnsignedInt = 0
            var greenInt: CUnsignedInt = 0
            var blueInt: CUnsignedInt = 0
            
            NSScanner(string:  redHex).scanHexInt(&redInt)
            NSScanner(string:  greenHex).scanHexInt(&greenInt)
            NSScanner(string:  blueHex).scanHexInt(&blueInt)
            
            
            let redFloat = CGFloat(redInt);
            let greenFloat = CGFloat(greenInt)
            let blueFloat = CGFloat(blueInt)
            
            self.init(red: redFloat / 255.0, green: greenFloat / 255.0, blue: blueFloat / 255.0, alpha: 1)
            
        } else {
            self.init()
        }
    }
}
