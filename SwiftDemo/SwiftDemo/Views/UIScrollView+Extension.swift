//
//  UIScrollView+Extension.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/3/7.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import UIKit

typealias VoidClosure = (() -> Void)

extension UIScrollView {
    
    var refreshHeaderView: RefreshHeaderView? {
        //  get  willSet set didSet, 方法， 以及如何控制 读写权限 ？？？？？
        get {
            return nil
        }
        
        set {
            
        }
    }
    
    func addPullRefresh(refreshBlock: VoidClosure) {
        
    }
}


