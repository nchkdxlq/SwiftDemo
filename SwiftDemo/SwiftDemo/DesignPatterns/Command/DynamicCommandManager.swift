//
//  DynamicCommandManager.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/7/25.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation

class DynamicCommandManager {
    
    var tm: TetrisMachine
    
    private var cmds = [DynamicCommand]()
    
    init(tm: TetrisMachine) {
        self.tm = tm
    }
    
    func toLeft() {
        let cmd = DynamicCommand(tm: tm) { (tm) in
            tm.toLeft()
        }
        cmd.execute()
        cmds.append(cmd)
    }
    
    func toRight() {
        let cmd = DynamicCommand(tm: tm) { (tm) in
            tm.toRight()
        }
        cmd.execute()
        cmds.append(cmd)
    }
    
    func toTransfrom() {
        let cmd = DynamicCommand(tm: tm) { (tm) in
            tm.transform()
        }
        cmd.execute()
        cmds.append(cmd)
    }
    
    func undo() {
        guard let _ = cmds.last else {
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
        while cmds.count > 0 {
            cmds.removeLast().execute()
        }
    }
    
    
}
