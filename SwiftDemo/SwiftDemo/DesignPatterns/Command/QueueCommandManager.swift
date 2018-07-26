//
//  QueueCommandManager.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/7/26.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation

class QueueCommandManager {
    
    let tm: TetrisMachine
    private var cmds = [DynamicCommand]()
    let queue: DispatchQueue
    
    init(tm: TetrisMachine) {
        self.tm = tm
        queue = DispatchQueue(label: "com.nchkdxlq.command")
    }
    
    func toLeft() {
        let cmd = DynamicCommand(tm: tm) { (tm) in
            tm.toLeft()
        }
        
        cmds.append(cmd)
        queue.sync {
            cmd.execute()
        }
    }
    
    func toRight() {
        let cmd = DynamicCommand(tm: tm) { (tm) in
            tm.toRight()
        }
        cmds.append(cmd)
        queue.sync {
            cmd.execute()
        }
    }
    
    func toTransfrom() {
        let cmd = DynamicCommand(tm: tm) { (tm) in
            tm.transform()
        }
        cmds.append(cmd)
        queue.sync {
            cmd.execute()
        }
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
