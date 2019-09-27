//
//  Error.swift
//  SyntaxDemo
//
//  Created by Knox on 2019/9/26.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation


func error_entry() {
    print("------ Error ------")
    
    selfDefineError()
    
    try_test()
    defer_test()
}

/*

 只要遵循`Error`协议，可以使用枚举、结构体、类自定义错误类型
 
 */


enum MyError : Error {
    case overflow
    case invalidInput(Int)
}

// 使用枚举定义错误类型
enum IntParsingError : Error {
    case overflow
    case invalidInput(Character)
}

extension Int {
    init(validating input: String) throws {
        throw IntParsingError.invalidInput("$")
    }
}

// 当每种错误类型有相同的数据，可以结构体定义错误类型
struct XMLParsingError: Error {
    enum ErrorKind {
        case invalidCharacter
        case mismatchedTag
        case internalError
    }
    
    let line: Int
    let column: Int
    let kind: ErrorKind
}

func parse(_ source: String) throws -> XMLNode {
    throw XMLParsingError(line: 19, column: 5, kind: .mismatchedTag)
}



func selfDefineError() {
     do {
         let price = try Int(validating: "$100")
        print(price)
     } catch IntParsingError.invalidInput(let invalid) {
         print("Invalid character: '\(invalid)'")
     } catch IntParsingError.overflow {
         print("Overflow error")
     } catch {
         print("Other error")
     }
    // Prints "Invalid character: '$'"
    
    let myXMLData = "<message/>"
    do {
        let element = try parse(myXMLData)
        print(element)
    } catch let e as XMLParsingError {
        print("Parsing error: \(e.kind) [\(e.line):\(e.column)]")
    } catch {
        print("Other error: \(error)")
    }
}

// throws   rethrows

// 当函数会抛出错误是，需要加上`throws`关键字
func devide(num1: Int, num2: Int) throws -> Int {
    if num2 == 0 {
        throw MyError.invalidInput(num2)
    }
    return num1 / num2
}

// 函数本身逻辑不会抛出错误，但传入的闭包可以抛出错误，使用`rethrows`关键字
func exec(fn: (Int, Int) throws -> Int, num1: Int, num2: Int) rethrows -> Int {
    // ...
    try fn(num1, num2)
    // ...
}

/*
 处理Error的方式有两种
 1. do-catch处理
 2. 当前函数不捕获Error, 函数也加上`throws`关键字，将Error抛给上层函数, 如果最顶层函数(main函数)依然没有捕获Error, 程序将终止
 
 */
func errorHandle() {
    // 模式匹配具体的错误
    do {
        let ret = try devide(num1: 20, num2: 10)
        print(ret)
    } catch MyError.invalidInput(let msg) { // 匹配某个具体的错误
        print(msg)
    } catch MyError.overflow {
        print("MyError.overflow")
    } catch is XMLParsingError { // 匹配某一类型的错误
        print("XMLParsingError")
    } catch let error as IntParsingError { // 匹配某一类型的错误，并且把错误命名为error
        print(error);
    } catch {
        // 默认处理，有一个隐式的error变量
        print(error)
    }
    
    try_test()
}

// 当前函数不处理错误，把错误抛给上层函数
func errorHandle_test() throws -> Void {
    let ret = try devide(num1: 20, num2: 10)
    print(ret)
}


/*
 try, 单独使用try, 当前函数不处理Error, 而是把Error抛给上一层函数
 try? try!
 
 可以使用try? 、try! 调用可能会抛出Error的函数, 这样就不需要处理Error了
 */


func try_test() {
    // 使用`try?`，如果函数没有抛出Error, 则返回结果是Optional类型，如果抛出错误，则为nil
    var _ = try? devide(num1: 20, num2: 10) // Optional(2) , Int?
    let a = try? devide(num1: 20, num2: 0) // nil
    print(a as Any)
    // 与上面等价
    var b: Int? = nil
    do {
        b = try devide(num1: 20, num2: 0)
    } catch {
        b = nil
    }
    print(b as Any)
    
    // 当能确定输入的参数一定不会抛出Error时，可以使用`try!`调用, 是代码更简洁
    var _ = try! devide(num1: 20, num2: 10) // 2
}



// MARK: - defer

func defer_test() {
    try? processFile("input.txt")
}


func processFile(_ fileName: String) throws {
    let file = open(fileName)
    
    defer {
        close(fileName) // 在函数结束之前，一定会调用
    }
    
    print("devide begin")
    let _ = try devide(num1: 20, num2: 0)
    print("devide end")
    
    print("process...")
}

func open(_ path: String) -> Int {
    print("open file")
    return 0
}

func close(_ path: String) {
    print("Close file")
}


// MARK: -  fatalError

/*
 如果遇到严重错误，希望结束程序运行时, 可以直接使用fatalError函数抛出错误 (无法使用`do-catch`捕获的错误)
 使用了fatalError就不需要再写`return`了
 */

func test(_ num: Int) -> Int {
    if (num > 0) {
        return 1
    }
    
    fatalError("num不能小于0")
}
