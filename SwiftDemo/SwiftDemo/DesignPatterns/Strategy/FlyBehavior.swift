//
//  FlyBehavior.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/7/29.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation


protocol FlyBehavior {
    func fly()
}


class FlyWithWings : FlyBehavior {
    
    func fly() {
        print("I am fly with wings!!")
    }
}


class FlyNoWay : FlyBehavior {
    
    func fly() {
        print("I can not fly")
    }
}


class FlyRocketPowerd : FlyBehavior {
    
    func fly() {
        print("I am flying with a recket")
    }
    
}

