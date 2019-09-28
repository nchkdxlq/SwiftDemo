//
//  Operator.swift
//  SyntaxDemo
//
//  Created by Knox on 2019/9/28.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation

func operator_entry() {
    
    overloadOperator()
    
    comparable_test()
}


// MARK: - Overload Operator

/*
 运算符重载有两中方式
 */

// 自定义运算符步骤， 先声明`运算符`名称, 再实现对应运算符函数

infix operator -->


struct Point {
    var x: Int
    var y: Int
    
}


// 方式一
//func == (_ lhs: Point, rhs: Point) -> Bool {
//    return lhs.x == rhs.x && lhs.y == rhs.y
//}

extension Point : Equatable {
    // 方式二，遵循Equatable协议，(推荐使用)
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    static func + (lhs: Self, rhs: Self) -> Self {
        return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func - (lhs: Self, rhs: Self) -> Self {
        return Point(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }
    
    static func -= (lhs: inout Self, rhs: Self) {
        lhs = lhs - rhs
    }
    
    // 计算两个点之间的距离
    static func --> (lhs: Self, rhs: Self) -> Double {
        let x = lhs.x - rhs.x
        let y = lhs.y - rhs.y
        return sqrt(Double(x*x + y*y))
    }
}


extension Point : Comparable {
    
    static func < (lhs: Self, rhs: Self) -> Bool {
        return (lhs.x * lhs.x + lhs.y * lhs.y) < (rhs.x * rhs.x + rhs.y * rhs.y)
    }
    
    static func <= (lhs: Self, rhs: Self) -> Bool {
        return (lhs.x * lhs.x + lhs.y * lhs.y) <= (rhs.x * rhs.x + rhs.y * rhs.y)
    }
}

func overloadOperator() {

    let p1 = Point(x: 10, y: 20)
    let p2 = Point(x: 11, y: 22)
    
    print(p1 == p2)
    
    let p3 = p2 - p1
    print(p3)
    
    var p4 = Point(x: 13, y: 14)
    p4 += p1
    print(p4)
    
    var p5 = Point(x: 30, y: 40)
    p5 -= p2
    print(p5)
    
    let p6 = Point(x: 0, y: 0)
    let p7 = Point(x: 3, y: 4)
    let d = p6 --> p7
    print(d)
}


func comparable_test() {
    let p1 = Point(x: 10, y: 20)
    let p2 = Point(x: 10, y: 20)
    
    print(p1 <= p2)
}
