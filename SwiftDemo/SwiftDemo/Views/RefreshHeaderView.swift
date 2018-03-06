//
//  RefreshHeaderView.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/3/6.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import UIKit

class RefreshHeaderView: RefreshComponent {

    override func contentOffsetDidChanged(_ newValue: CGPoint, oldValue: CGPoint) {
        super.contentOffsetDidChanged(newValue, oldValue: oldValue)
        var delta: CGFloat = 0
        if #available(iOS 11.0, *) {
            delta = self.scrollView!.contentInset.top + self.scrollView!.adjustedContentInset.top + newValue.y
        } else {
            // Fallback on earlier versions
            delta = self.scrollView!.contentInset.top + newValue.y
        }
        if delta < 0 {
            print("1111111111")
        } else {
            print("2222222222")
        }
    }
}
