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

/*
 总结：
 1. 适配器需要继承src类，这算是一个缺点
 2. 并且dst要求是接口、协议
 3. 由于继承了src类，所以可以根据需求重写src类的方法，是的Adapter的灵活性增强了。
 
 */


//MARK: - 对象适配模式（常用）

class VoltageAdpter2 {
    
    let vol220: Voltage220
    
    init(vol: Voltage220) {
        vol220 = vol
    }
}

extension VoltageAdpter2 : Voltage5Protocol {
    
    func output5V() -> Int {
        let vol = vol220.output220()
        
        var des = 0;
        des = vol / 44
        
        return des
    }
}

/*
 总结：
 1. 对象适配器和类适配器算是同一种思想，只不过实现方式不同
 2. 根据合成复用原则，组合大于继承，所以他解决了类适配器必须继承src的局限性问题。，
    也不再强求dst必须是接口，同样的它使用的成本更低，更灵活。
 
 
 */


