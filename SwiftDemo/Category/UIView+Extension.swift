//
//  UIView+Extension.swift
//  SwiftDemo
//
//  Created by Knox on 2019/9/29.
//  Copyright © 2019 luoquan. All rights reserved.
//


import UIKit


extension UIView {
    
    static var reuseIndentifier: String {
        return NSStringFromClass(self)
    }
    
}
