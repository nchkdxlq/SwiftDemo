//
//  UITableView+Extension.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 2016/12/25.
//  Copyright © 2016年 nchkdxlq. All rights reserved.
//

import UIKit

extension UITableView {
    
    func hiddenEmptyCells() {
        tableFooterView = UIView()
    }
    
    func updateCells(_ closure: (() -> Void)) {
        beginUpdates()
        closure()
        endUpdates()
    }
}
