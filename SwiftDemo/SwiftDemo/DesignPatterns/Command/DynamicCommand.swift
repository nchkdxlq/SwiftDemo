//
//  DynamicCommand.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/7/25.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation

typealias DynamicClosure = (TetrisMachine) -> Void

/*
    1. 实现命令协议
    2. 传递接收者
 */

class DynamicCommand: TMCommandProtocol {
    
    var tm: TetrisMachine
    var closure: DynamicClosure
    
    init(tm: TetrisMachine, closure: @escaping DynamicClosure) {
        self.tm = tm
        self.closure = closure
    }
    
    func execute() {
        closure(tm)
    }
}
