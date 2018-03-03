//
//  ClosureSyntax.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 5/28/16.
//  Copyright © 2016 nchkdxlq. All rights reserved.
//

import UIKit


/*
 闭包表达式
 
 闭包的格式
 
 {
    (params) -> (return Value) in
 
    some Code
 }
 
 闭包简写格式
 如果闭包没有参数并且没有返回值，可以把 in 之前的所有东西删除(包括 in), 例如调用下面的 doSomething 函数
 
 
 闭包作为数据类型时的写法
 
 (params) -> (return Value) 
 1、有返回值，有参数
 (a: Int, b: Int) -> (Int)

 2、有返回值无参数
 () -> (Int)

 3、无返回值有参数
 (a: Int, b: Int) -> ()
 
 4、无参数无返回值
 () -> ()
 

 
 
 
 */

class ClosureSyntax: NSObject {
    
    
    func testClosureExpression()
    {
        
        /*
         1、2、3 比较：闭包的在函数参数的不同位置的不同写法
         
         
         3、4、5比较：闭包是否有返回值、参数的闭包的写法
         
         */
        
        // 1.闭包可以作为实参传递给函数,放在()里面
        doSomething( finish: {
            print("1 ---- fihished")
        })
        
        
        // 2.如果函数只接收一个参数并且是闭包，那么 （）可以省略
        doSomething {
            print("2 ---- fihished")
        }
        
        // 3.闭包是函数的最后一个参数(俗称 '尾闭包')，那么闭包可以放在（）的后面
        doSomething(num: 10) {
            print("3 ---- fihished")
        }
        
        // 4.有参数、无返回值
        showFullName { (firstName, secondName) in
            print(" \(firstName) \(secondName)")
        }
        
        // 5.闭包的完整形式，有参数、有返回值
        caculaterNum { (left, right) -> (Int) in
            return left + right
        }
        
        let closure = getClosure()
        let sum = closure(10, 10)
        print("sum = \(sum)")
        
        let sum_1 = getClosure()(10, 10)
        
        print("sum = \(sum_1)")
    }
    
    
    
    // MARK: - closure as param
    /*
     闭包作为函数参数时的格式(作为数据类型时的格式)
     (params) -> (return type)
     
     */
    
    
    // 无参数、无返回值
    func doSomething(finish: ()->())
    {
        print("i dong something now...")
        finish()
    }
    
    
    func doSomething(num: Int, finish: ()->())
    {
        print("num = \(num)")
        finish()
    }

    
    // 有参数、无返回值
    func showFullName(link: (_ firstName :String, _ secondName :String) -> ())
    {
        link("cookie", "luo")
    }
    
    
    // (left: Int, right: Int) -> (Int) 为闭包的类型, 有参数有返回值
    func caculaterNum(caculate: (_ left: Int, _ right: Int) -> (Int))
    {
        let result = caculate(10, 29)
        print("result = \(result)")
    }
    
    // MARK: - closure as return data
    
    func getClosure() -> ((_ left: Int, _ right: Int) -> Int) {
        return { (left, right) -> (Int) in
            return left + right
        }
    }
    
    
    func testClosure() {
        
        let average1 = averageofSumSquares(a: 3, b: 4)
        let average2 = averageofSumCobe(a: 3.0, b: 4.0)
        print("\(average1), \(average2)")
        
        let average3 = averageofFunction(a: 3, b: 4, f: {(x: Float) -> Float in return x * x})
        print("\(average3)")
        let _ = averageofFunction(a: 3, b: 4) { x in
            return x * x
        }
        let _ = averageofFunction(a: 3, b: 4) { $0 * $0 }
        
        
        var result = applyTwoTimes(x: 3) { (param) -> CGFloat in
            return param + param
        }
        print("reslut = \(result)")
        result = applyKtimes(x: 3, k: 5, f: { (param) -> CGFloat in
            return param + param
        })
        result = applyKtimes(x: 2, k: 3) { $0 + $0 }
    }
    
    
    // MARK: - 命名闭包
    
    func square(a: Float) -> Float {
        return a * a
    }
    
    func cube(a: Float) -> Float {
        return a * a * a
    }
    
    func averageofSumSquares(a: Float, b: Float) -> Float {
        return (square(a: a) + square(a: b) / 2.0)
    }
    
    func averageofSumCobe(a: Float, b: Float) -> Float {
        return (cube(a: a) + cube(a: b)) / 2.0
    }
    
    func averageofFunction(a: Float, b: Float, f: ((Float) -> Float)) -> Float {
        return (f(a) + f(b)) / 2.0
    }
    
    
    func applyTwoTimes(x: CGFloat, f: ((_ x: CGFloat) -> CGFloat)) -> CGFloat {
        return f(f(x))
    }
    
    func applyKtimes(x: CGFloat, k: Int, f: ((_ param: CGFloat) -> CGFloat)) -> CGFloat {
        var result = x
        for _ in 0..<k {
            result = f(result)
        }
        return result
    }
    
    
    
    
    
    
    
}
