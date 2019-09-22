//
//  Closure.swift
//  SyntaxDemo
//
//  Created by Knox on 2019/9/21.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation


/*
 
 ## 闭包的定义
 一个函数和它所捕获的变量/常量环境组合起来，称为闭包
 1. 一般是指定义在函数内部的函数
 2. 一般它捕获的是外层函数的局部变量/常量
 
 可以把闭包想象成一个类的实例对象
 1. 内存在堆空间
 2. 捕获的局部变量/常量就是对象的成员(存储属性)
 3. 组成闭包的函数就是类内部定义的方法

 */
class Closure {
    var num = 0
    func plus(_ i: Int) -> Int {
        num += i
        return num
    }
}


func closure_entry() {
    print("------- Closure ------")
    
//    test_getFn()
    test_getFn2()
}


typealias Fn = (Int) -> Int
typealias Fn2 = (Int) -> (Int, Int)

func test_getFn() {
    let fn1 = getFn()
    let _ = fn1(1)
//    let _ = fn1(2)
//    let _ = fn1(3)
//    let _ = fn1(4)
}


func test_getFn2() {
    let (p, m) = getFn2()
    
    print(p(5))
    print(m(4))
}

// 返回plus和num形成的闭包
func getFn() -> Fn {
    var num1 = 0
    func plus(_ i: Int) -> Int {
        num1 += i
        return num1
    }
    
    return plus
}

func getFn2() -> (Fn2, Fn2) {
    var num1 = 10
    var num2 = 11
    
    func plus(_ i: Int) -> (Int, Int) {
        num1 += i
        num2 += i << 1
        return (num1, num2)
    }
    
    func minus(_ i: Int) -> (Int, Int) {
        num1 -= i
        num2 -= i << 1
        return (num1, num2)
    }
    
    return (plus, minus)
}
