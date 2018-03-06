//
//  RefreshComponent.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/3/6.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import UIKit

let kRefreshContentSize = "contentSize"
let kRefreshContentOffset = "contentOffset"

class RefreshComponent: UIView {

    weak var scrollView: UIScrollView?
    var scrollViewInsets = UIEdgeInsets.zero
    
    var isObserving = false
    var isRefreshing = false
    var isIgnoreObserving = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = .flexibleWidth
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeObserver()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        guard let scrollView = newSuperview as? UIScrollView else {
            return
        }
        self.scrollView = scrollView;
        self.scrollViewInsets = scrollView.contentInset
        
        addObserver()
    }
    
    func addObserver() {
        if isObserving == false {
            isObserving = true
            let options: NSKeyValueObservingOptions = [.new, .old];
            scrollView?.addObserver(self,
                                    forKeyPath: kRefreshContentSize,
                                    options: options,
                                    context: nil)
            scrollView?.addObserver(self,
                                    forKeyPath: kRefreshContentOffset,
                                    options: options,
                                    context: nil)
        }
    }
    
    func removeObserver() {
        if isObserving {
            scrollView?.removeObserver(self, forKeyPath: kRefreshContentSize)
            scrollView?.removeObserver(self, forKeyPath: kRefreshContentOffset)
            isObserving = false
        }
    }
    
    func contentSizeDidChanged(_ newValue: CGSize, oldValue: CGSize) {
        
    }
    
    func contentOffsetDidChanged(_ newValue: CGPoint, oldValue: CGPoint) {
        print("contentOffset newValue = \(newValue), oldValue = \(oldValue)")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard isHidden == false, isIgnoreObserving == false,
            let __keyPath = keyPath,
            let __change = change else {
            return
        }

        if __keyPath == kRefreshContentSize {
            if let newValue = __change[NSKeyValueChangeKey.newKey] as? CGSize,
                let oldValue = __change[NSKeyValueChangeKey.oldKey] as? CGSize {
                if newValue != oldValue {
                    contentSizeDidChanged(newValue, oldValue: oldValue)
                }
            }
        } else if __keyPath == kRefreshContentOffset {
            if let newValue = __change[NSKeyValueChangeKey.newKey] as? CGPoint,
                let oldValue = __change[NSKeyValueChangeKey.oldKey] as? CGPoint {
                if newValue != oldValue {
                    contentOffsetDidChanged(newValue, oldValue: oldValue)
                }
            }
        }
    }
}
