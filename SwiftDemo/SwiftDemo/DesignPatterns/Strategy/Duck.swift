//
//  Duck.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/7/29.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation

class Duck {
    
    var flyBehavior: FlyBehavior?
    var quackBehavior: QuackBehavior?
    
    
    func performFly() {
        flyBehavior?.fly()
    }
    
    func performQuack() {
        quackBehavior?.quack()
    }
    
    
    func setFlyBehavior(_ fb: FlyBehavior) {
        flyBehavior = fb
    }
    
    func setQuackBehavior(_ qb: QuackBehavior) {
        quackBehavior = qb
    }
    
    
    func display() {
        
    }
}



class MallarDuck : Duck {
    
    override init() {
        super.init()
        flyBehavior = FlyWithWings()
        quackBehavior = Quack()
    }

    override func display() {
        print("I am a real Mallard duck")
    }
    
}


class ModelDuck : Duck {
    
    override init() {
        super.init()
        flyBehavior = FlyNoWay()
        quackBehavior = Quack()
    }
    
    override func display() {
        print("I am a model duck")
    }
    
}


