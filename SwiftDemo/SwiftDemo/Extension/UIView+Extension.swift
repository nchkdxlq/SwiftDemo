//
//  UIView+Extension.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 2016/12/4.
//  Copyright © 2016年 nchkdxlq. All rights reserved.
//

import UIKit


extension UIView {
    
    static var reuseIndentifier: String {
        return NSStringFromClass(self)
    }
    
}
