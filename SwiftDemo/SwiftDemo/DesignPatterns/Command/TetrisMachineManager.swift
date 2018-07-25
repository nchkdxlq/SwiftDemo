//
//  TetrisMachineManager.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/7/25.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation


// 请求者(官方叫法) -> 管理器

//  具体命令可以在内部创建、也可以在外部创建
class TetrisMachineManager {
    
    private var cmds = [MTCommandProtocol]()
    
    var tm: TetrisMachine
    var leftCmd: TMLeftCommand
    var rightCmd: TMRightCommand
    var transformCmd: TMTransformCommand
    
    init(tm: TetrisMachine,
         leftCmd: TMLeftCommand,
         rightCmd: TMRightCommand,
         transformCmd: TMTransformCommand) {
        
        self.tm = tm
        self.leftCmd = leftCmd
        self.rightCmd = rightCmd
        self.transformCmd = transformCmd
    }
    
    
    //MARK: - 业务逻辑
    
    /*
     需求：
     1. 支持撤销操作
     
     */
    
    func toLeft() {
        leftCmd.execute()
        cmds.append(TMLeftCommand(tm: tm))
    }
    
    func toRight() {
        rightCmd.execute()
        cmds.append(TMRightCommand(tm: tm))
    }
    
    func toTransfrom() {
        transformCmd.execute()
        cmds.append(TMTransformCommand(tm: tm))
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
