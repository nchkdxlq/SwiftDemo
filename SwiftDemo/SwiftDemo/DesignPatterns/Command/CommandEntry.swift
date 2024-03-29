//
//  CommandEntry.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/7/25.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation


func commandEntry() {
    
    //MARK: - Command
    
    func commandDemo() {
        let tm = TetrisMachine()
        
        let leftCmd = TMLeftCommand(tm: tm)
        let rightCmd = TMRightCommand(tm: tm)
        let transformCmd = TMTransformCommand(tm: tm)
        
        // 直接调用 tm 的操作，不能很方便的对操作做额外的记录，比如回退操作；
        // 而用Manager管理tm, 在Manager中可以做很多额外的事情。
        //    tm.toLeft()
        //    tm.toRight()
        //    tm.transform()
        
        let tmManager = TetrisMachineManager(tm: tm,
                                             leftCmd: leftCmd,
                                             rightCmd: rightCmd,
                                             transformCmd: transformCmd)
        
        tmManager.toLeft()
        tmManager.toRight()
        tmManager.toTransfrom()
        
        tmManager.undo()
        tmManager.undoAll()
    }
    
//    commandDemo()
    
    //MARK: - DynamicCommand
    
    func dynamicCommandDemo() {
        // 系统类实现 NSUndoManager
        
        let tm = TetrisMachine()
        
        let cmdManager = DynamicCommandManager(tm: tm)
        cmdManager.toLeft()
        cmdManager.toRight()
        cmdManager.toTransfrom()
        
        cmdManager.undo()
        cmdManager.undoAll()
    }
    
    dynamicCommandDemo()
    
    
    //MARK: - WapperCommand
    
    func wapperCommandDemo() {
        
        let cmdManager = WrapperCommandManager(tm: TetrisMachine())
        
        cmdManager.toLeft()
        cmdManager.toRight()
        cmdManager.toTransform()
        
        cmdManager.undo()
        cmdManager.undoAll()
    }
    
    wapperCommandDemo()
    
    //MARK: - GenericCommand
    
    func genericCommandDemo() {
        let cmdManager = GenericsCommandManager(tm: TetrisMachine())
        
        cmdManager.toLeft()
        cmdManager.toRight()
        cmdManager.toTransfrom()
        
        cmdManager.undo()
        cmdManager.undoAll()
    }
    
    genericCommandDemo()
    
    //MARK: - QueueCommand
    
    func queueCommand() {
        let cmdManager = QueueCommandManager(tm: TetrisMachine())
        
        cmdManager.toLeft()
        cmdManager.toRight()
        cmdManager.toTransfrom()
        
        cmdManager.undo()
        cmdManager.undoAll()
    }
    
    queueCommand()
    
    //MARK: - ClosureCommand
    
    func closureCommand() {
        let cmdManager = ClosureCommandManager(tm: TetrisMachine())
        
        cmdManager.toLeft()
        cmdManager.toRight()
        cmdManager.toTransform()
        
        cmdManager.undo()
        cmdManager.undoAll()
    }
    
    closureCommand()
}
