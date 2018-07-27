//
//  Adapter.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/7/27.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation

/*
 
 ## 适配器设计模式
    定义：将一个类的接口适转换成客户端期望的另一个接口，将原本因接口不匹配不能工作的两个类可以协同工作。
    只要目的是解决兼容性问题。
    需要被适配的类、接口、对象（我们有的），简称 src（source）
    最终需要的输出（我们想要的），简称 dst (destination，即Target)
    适配器称之为 Adapter
 
 ## 分类
    1. 类适配器模式
    2. 对象适配器模式
    3. 接口适配器
 
 ## 使用场景
 
 参考链接：
 1. https://blog.csdn.net/zxt0601/article/details/52848004
 2. https://blog.csdn.net/lmj623565791/article/details/24602057
 3. https://blog.csdn.net/carson_ho/article/details/54910430
 
 
 
 */



//MARK: - 类适配器模式

// Target
protocol Voltage5Protocol {
    
    func output5V() -> Int
}

// Source
class Voltage220 {
    func output220() -> Int {
        let src = 220
        print("This is \(src) V")
        return src
    }
}

// Adapter

class VoltageAdapter : Voltage220 {
    
}

extension VoltageAdapter : Voltage5Protocol {
    
    func output5V() -> Int {
        let voltage = output220()
        return voltage / 44
    }
}


// client

class Mobile {
    
    func charging(voltage: Voltage5Protocol) {
        if voltage.output5V() == 5 {
            print("This is 5V that I want")
        } else {
            print("This is not fit me")
        }
    }
}




