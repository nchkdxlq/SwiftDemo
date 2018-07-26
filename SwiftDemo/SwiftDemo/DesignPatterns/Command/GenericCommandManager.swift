//
//  GenericCommandManager.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/7/26.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation


class GenericCommandManager {
    
    let tm: TetrisMachine
    var cmds = [GenericCommand<TetrisMachine>]()
    
    init(tm: TetrisMachine) {
        self.tm = tm
    }
    
    
    func toLeft() {
        let cmd = GenericCommand<TetrisMachine>(receiver: tm) { (tm) in
            tm.toLeft()
        }
        cmd.execute()
        cmds.append(cmd)
    }
    
    func toRight() {
        let cmd = GenericCommand<TetrisMachine>(receiver: tm) { (tm) in
            tm.toRight()
        }
        cmd.execute()
        cmds.append(cmd)
    }
    
    func toTransfrom() {
        let cmd = GenericCommand<TetrisMachine>(receiver: tm) { (tm) in
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
        
        let wrapperCmd = WrapperCommand(cmds: cmds)
        wrapperCmd.execute()
    }
    
    
}



