//
//  WrapperCommand.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/7/26.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation

/*
 复合命令：执行多个命令
 
 
 */

class WrapperCommand : TMCommandProtocol {
    
    let cmds : [TMCommandProtocol]
    
    init(cmds: [TMCommandProtocol]) {
        self.cmds = cmds
    }
    
    
    func execute() {
        for cmd in cmds {
            cmd.execute()
        }
    }
    
}
