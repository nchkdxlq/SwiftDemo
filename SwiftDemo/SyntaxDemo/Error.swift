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
    
}

