//
//  UIColor+Extension.swift
//  SwiftDemo
//
//  Created by Knox on 2019/9/29.
//  Copyright © 2019 luoquan. All rights reserved.
//

import UIKit


extension UIColor {
    
    static func RGBA(_ r: Int, _ g: Int, _ b: Int, _ a: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: a)
    }
    
    static func RGB(_ r: Int, _ g: Int, _ b: Int) -> UIColor {
        return RGBA(r, g, b, 1.0)
    }
    
    convenience init(r: Int, g: Int, b: Int, a: CGFloat = 1.0) {
        self.init(red: CGFloat(r)/255.0,
                  green: CGFloat(g)/255.0,
                  blue: CGFloat(b)/255.0,
                  alpha: a)
    }
    
}
