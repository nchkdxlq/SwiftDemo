//
//  QuackBehavior.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/7/29.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation

protocol QuackBehavior {
    func quack()
}


class Quack: QuackBehavior {
    
    func quack() {
        print("Quack")
    }
}


class MuteQuack: QuackBehavior {
    
    func quack() {
        print("<< Silence >>")
    }
}


