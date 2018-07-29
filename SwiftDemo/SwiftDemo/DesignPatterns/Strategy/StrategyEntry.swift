//
//  StrategyEntry.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/7/29.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation


/*
 
 策略设计模式：
 定义了算法族，分别封装起来，让它们之间可以互相替换，
 次模式让算法的变化独立于使用算法的客户端。
 
 
 */



func strategyEntry() {
    
    let duck = MallarDuck()
    duck.display()
    duck.performFly()
    duck.performQuack()
    
    
    let model = ModelDuck()
    model.display()
    model.performFly()
    model.performQuack()
    model.setFlyBehavior(FlyRocketPowerd())
    model.performFly()
}
