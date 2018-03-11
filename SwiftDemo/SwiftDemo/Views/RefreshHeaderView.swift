//
//  RefreshHeaderView.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/3/6.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import UIKit

class RefreshHeaderView: RefreshComponent {

    var animator: HeaderAnimator!
    
    convenience init(animator: HeaderAnimator) {
        self.init()
        self.animator = animator
        addSubview(animator)
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        guard let scrollView = newSuperview as? UIScrollView else {
            return
        }
        
        var top: CGFloat = 0
        if #available(iOS 11.0, *) {
            top = scrollView.contentInset.top + scrollView.adjustedContentInset.top
        } else {
            // Fallback on earlier versions
            top = scrollView.contentInset.top
        }
        
        let Y = top - animator.bounds.height
        
        frame = CGRect(x: 0,
                       y: Y,
                       width: scrollView.bounds.width,
                       height: animator.bounds.height)
        animator.center = CGPoint(x: frame.width/2, y: frame.height/2)
    }
    
    override func contentOffsetDidChanged(_ newValue: CGPoint,
                                 oldValue: CGPoint,
                                 newDragging: Bool,
                                 oldDragging: Bool) {
        super.contentOffsetDidChanged(newValue,
                                      oldValue: oldValue,
                                      newDragging: newDragging,
                                      oldDragging: oldDragging)
        if self.isRefreshing {
            print("refreshing")
            return
        }
        var delta: CGFloat = 0
        if #available(iOS 11.0, *) {
            delta = self.scrollView!.contentInset.top + self.scrollView!.adjustedContentInset.top + newValue.y
        } else {
            // Fallback on earlier versions
            delta = self.scrollView!.contentInset.top + newValue.y
        }
        
        if delta <= 0 {
            let bRefresh = animator.shouldRefreshWithDistance(distance: -delta,
                                                              newDragging: newDragging,
                                                              oldDragging: oldDragging)
            if bRefresh {
                var insets = self.scrollViewInsets
                insets.top += animator.bounds.height
                UIView.animate(withDuration: 0.25, animations: {
                    self.scrollView!.contentInset = insets
                })
                startRefresh()
            }
        } else {
            
        }
    }

    
    func startRefresh() {
        if self.isRefreshing {
            return
        }
        print("aaaaaaaaaaaaaaaaa")
        self.isRefreshing = true
        animator.startAnimating()
        refreshBlock?()
    }
    
    func endRefresh() {
        if self.isRefreshing == false {
            return
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.scrollView?.contentInset = self.scrollViewInsets
        }) { (finish) in
            self.isRefreshing = false
            self.animator.stopAnimating()
            print("bbbbbbbbbbbbbbbb")
        }
    }
    
}
