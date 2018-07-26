//
//  ClosureCommandManager.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/7/26.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation

typealias ClosureCommand = (_: TetrisMachine) -> Void


class ClosureCommandManager {
    
    var tm: TetrisMachine
    var cmds = [ClosureCommand]()
    
    init(tm: TetrisMachine) {
        self.tm = tm
    }
    
    
    func toLeft() {
        let cmd = { (tm: TetrisMachine) -> Void in
            tm.toLeft()
        }
        cmd(tm)
        cmds.append(cmd)
    }
    
    func toRight() {
        let cmd = { (tm: TetrisMachine) -> Void in
            tm.toRight()
        }
        cmd(tm)
        cmds.append(cmd)
    }
    
    func toTransform() {
        let cmd = { (tm: TetrisMachine) -> Void in
            tm.transform()
        }
        cmd(tm)
        cmds.append(cmd)
    }
    
    
    func undo() {
        if cmds.count == 0 {
            return
        }
        cmds.removeLast()(tm)
    }
    
    func undoAll() {
        while cmds.count > 0 {
            cmds.removeLast()(tm)
        }
    }
}

