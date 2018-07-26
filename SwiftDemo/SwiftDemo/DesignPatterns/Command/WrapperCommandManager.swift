//
//  WrapperCommandManager.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/7/26.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation


class WrapperCommandManager {
    
    let tm: TetrisMachine
    private var cmds = [WrapperCommand]()
    
    init(tm: TetrisMachine) {
        self.tm = tm
    }
    
    func toLeft() {
        let dyCmd = DynamicCommand(tm: tm) { (tm) in
            tm.toLeft()
        }
        let wrapperCmd = WrapperCommand(cmds: [dyCmd])
        cmds.append(wrapperCmd)
        wrapperCmd.execute()
    }
    
    func toRight() {
        let dyCmd = DynamicCommand(tm: tm) { (tm) in
            tm.toRight()
        }
        
        let wrapperCmd = WrapperCommand(cmds: [dyCmd])
        cmds.append(wrapperCmd)
        wrapperCmd.execute()
    }
    
    
    func toTransForm() {
        let dyCmd = DynamicCommand(tm: tm) { (tm) in
            tm.transform()
        }
        let wrapperCmd = WrapperCommand(cmds: [dyCmd])
        cmds.append(wrapperCmd)
        wrapperCmd.execute()
    }
    
    func undo() {
        if cmds.count == 0 {
            return
        }
        print("\(#function)")
        cmds.removeLast().execute()
    }
    
    func undoAll() {
        if cmds.count == 0 {
            return
        }
        print("\(#function)")
        // 用现有的命令数组再创建一个复合命令
        let cmd = WrapperCommand(cmds: self.cmds)
        cmd.execute()
        cmds.removeAll()
    }
    
}
