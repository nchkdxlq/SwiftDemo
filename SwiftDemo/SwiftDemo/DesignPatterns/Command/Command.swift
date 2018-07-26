//
//  Command.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/7/25.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation

// 具体命令

class TMLeftCommand : TMCommandProtocol {
    
    var tm: TetrisMachine
    
    init(tm: TetrisMachine) {
        self.tm = tm
    }
    
    func execute() {
        tm.toLeft()
    }
    
}


////////////////////////////////////////

class TMRightCommand : TMCommandProtocol {
    
    
    var tm: TetrisMachine
    
    init(tm: TetrisMachine) {
        self.tm = tm
    }
    
    func execute() {
        tm.toRight()
    }
}



////////////////////////////////////////


class TMTransformCommand : TMCommandProtocol {
    

    var tm: TetrisMachine
    
    init(tm: TetrisMachine) {
        self.tm = tm
    }
    
    func execute() {
        tm.transform()
    }
}
