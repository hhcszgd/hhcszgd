//
//  UIColor+Extension.swift
//  Weibo
//
//  Created by apple on 15/11/30.
//  Copyright © 2015年 mac. All rights reserved.
//

import UIKit

extension UIColor {
    
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.characters.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString.substring(from: start)
            
            if hexColor.characters.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
    
    
    
    
    
    class func randomColor() -> UIColor {
        
//        let r = CGFloat(random() % 255) / 255.0
//        let g = CGFloat(random() % 255) / 255.0
//        let b = CGFloat(random() % 255) / 255.0
        let r = CGFloat(arc4random_uniform(225)) / 255.0
        let g = CGFloat(arc4random_uniform(225)) / 255.0
        let b = CGFloat(arc4random_uniform(225)) / 255.0
        let randomColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        
        return randomColor
    }
    
  }
