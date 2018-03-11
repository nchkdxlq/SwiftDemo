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
    
    private struct AssociatedKey {
        static var refreshHeader = "refreshHeader"
        static var refreshFooter = "refreshFooter"
    }
    
    var refreshHeader: RefreshHeaderView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.refreshHeader) as? RefreshHeaderView
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKey.refreshHeader, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
        self.refreshHeader = refreshView
    }
    
}


