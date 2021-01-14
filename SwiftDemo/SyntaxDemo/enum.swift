//
//  enum.swift
//  SyntaxDemo
//
//  Created by Knox on 2019/9/9.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation



enum CompassPoint {
    case east
    case south
    case west
    case north
}

let point = CompassPoint.east

enum Suit: String {
    case spades = "黑桃"
    case hearts = "红桃"
    case clubs = "草花"
    case diamonds = "方片"
}



/*
 
 1. 成员值
 2. 关联值 (associate value) 关联的值存储在枚举变量中
 3. 原始值 (rawValue)
 
 
 总结：
 1. 枚举的`关联值`存储在枚举变量内存中, 关联值枚举类型的内存空间模型为: 前面的字节是`关联值`，接下来的字节才是`成员值`
 2. `原始值`不存储在枚举变量中, 通过枚举的rawValue(计算属性)属性获取, 所以`原始值类型`不影响枚举变量占用内存空间大小
 3. 成员值只需要一个字节存储, 当枚举只有一个成员时, 枚举变量占用的内存空间为0.
 
 */

func enum_entry() {
    print("\n--------- enum ---------\n")
    
//    memoryLayout_test1()
//    memoryLayout_test2()
    enum_memoryLayout()
    recursive_test()
    
    let suit = Suit.spades
    print("rawValue", suit.rawValue)
    print("hashValue", suit.hashValue)
}



/*
    MemoryLayout<Int>.size  // 实际使用的内存大小
    MemoryLayout<Int>.stride // 分配的内存大小
    MemoryLayout<Int>.alignment // 内存对齐
 */

// 查看某种`数据类型`占用内存
fileprivate func memoryLayout_test1() {
    let size = MemoryLayout<Int>.size
    let stride = MemoryLayout<Int>.stride
    let alignment = MemoryLayout<Int>.alignment
    
    print("size = \(size), stride = \(stride), alignment = \(alignment)")
}


// 查看某个`变量/常量`占用内存
fileprivate func memoryLayout_test2() {
    let num = 10
    
    let size = MemoryLayout.size(ofValue: num)
    let stride = MemoryLayout.stride(ofValue: num)
    let alignment = MemoryLayout.alignment(ofValue: num)
    
    print("size = \(size), stride = \(stride), alignment = \(alignment)")
}


fileprivate func enum_memoryLayout() {
    enum TestEnum {
        case test1(Int, Int, Int)
        case test2(Int, Int)
        case test3(Int)
        case test4(Bool)
        case test5
    }

    var test1 = TestEnum.test1(10, 20, 30)
    print(Mems.ptr(ofVal: &test1))
    /*
     
     0A 00 00 00 00 00 00 00  // 关联值
     14 00 00 00 00 00 00 00  // 关联值
     1E 00 00 00 00 00 00 00  // 关联值
     00                       // 成员值
     00 00 00 00 00 00 00
     
     前24个字节存放`关联值`,第25个字节存放`成员值`,后面的7个字节不使用
     
     */
    let size = MemoryLayout.size(ofValue: test1)
    let stride = MemoryLayout.stride(ofValue: test1)
    let alignment = MemoryLayout.alignment(ofValue: test1)
    print("size = \(size), stride = \(stride), alignment = \(alignment)")
    
    test1 = TestEnum.test2(40, 50)
    /*
     
     28 00 00 00 00 00 00 00
     32 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     01
     00 00 00 00 00 00 00
     
     */
    
    
    test1 = .test5
    /*
     
     00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     00 00 00 00 00 00 00 00
     04                      //成员值
     00 00 00 00 00 00 00
     
     */
}


// 递归枚举
indirect enum ArithExpr {
    case number(Int)
    case addition(ArithExpr, ArithExpr)
    case subtraction(ArithExpr, ArithExpr)
    
    func calculate() -> Int {
        switch self {
        case let .number(num):
            return num
        case let .addition(left, right):
            return left.calculate() + right.calculate()
        case let .subtraction(left, right):
            return left.calculate() - right.calculate()
        }
    }
}


func recursive_test() {
    let a = ArithExpr.number(10)
    let b = ArithExpr.number(5)
    let sum = ArithExpr.addition(a, b)
    let sub = ArithExpr.subtraction(sum, a)
    
    let result = sub.calculate()
    print("ArithExpr = \(result)")
    
    if case ArithExpr.number(let num) = a {
        
    }
}

