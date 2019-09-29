//
//  UITableView+Extension.swift
//  SwiftDemo
//
//  Created by Knox on 2019/9/29.
//  Copyright © 2019 luoquan. All rights reserved.
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
