//
//  TMCommandProtocol.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/7/25.
//  Copyright © 2018年 luoquan. All rights reserved.
//

/*
 
 定义：
 1. 将一个请求封装成为一个对象，从而让用户使用不同的请求将客户端参数化
 2. 对请求排队或者记录请求日志，以及支持撤销操作
    (让我们的程序扩展性更好，耦合降低)
 
 应用场景：
    当需要将方法调用包装成一个对象，以延时调用，或者让其它组件在对其
    内部实现细节不了解的情况下进行调用的时候可以使用命令模式。
 场景1：程序支持撤销和恢复
 场景2：记录请求日志，当系统故障这些命令可以重新被执行
 场景3：想用对象参数化一个动作以执行操作，并且用不同命令替换回调函数
 
 角色划分：
 receiver: 接收者 (负责具体的功能逻辑、执行具体的逻辑)
 Command: 接口命令 (命令抽象)
 ConcreteCommand: 具体命令 (调用接收者的逻辑方法、行为方法)，需要持有接收者对象
 Invoker: 请求者
 
 
 
 原理理解：
 
 角色划分：
 角色一：命令接口（抽象命令） -> MTCommandProtocol
 角色二：具体命令
        1. 左命令   toLeft
        2. 有命令   toRight
        3. 变形命令 transform
 角色三：接收者
        TetrisMachine
 
 角色四：请求者 ->  命令管理器
        TetrisMachineManager
 
 */


import Foundation


//角色一：命令接口（抽象命令）
protocol MTCommandProtocol {
    
    func execute();
    
}

