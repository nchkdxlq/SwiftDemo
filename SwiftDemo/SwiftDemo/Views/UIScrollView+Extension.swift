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
    
    func addPullRefresh(refreshBlock: @escaping VoidClosure) {
        let animator = HeaderAnimator(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: bounds.width,
                                                    height: 60))
        addPullRefresh(animator: animator, refreshBlock: refreshBlock)
    }
    
    func addPullRefresh(animator: HeaderAnimator, refreshBlock: @escaping VoidClosure) {
        let refreshView = RefreshHeaderView(animator: animator)
        refreshView.refreshBlock = refreshBlock
        insertSubview(refreshView, at: 0)
    }
    
}


