//
//  Generics.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/9/10.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation


func genericsEntry() {
    test_stack()
}


// MARK: - Type Parameters (泛型参数)

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let tmp = a
    a = b
    b = tmp
}

func swapTowDoubles(_ a: inout Double, _ b: inout Double) {
    let tmp = a
    a = b
    b = tmp
}


func swapTowStrings(_ a: inout String, _ b: inout String) {
    let tmp = a
    a = b
    b = tmp
}

/**
 
 三个函数逻辑完全一样，唯一不同的是参数的类型。
 
 */

// 泛型函数
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let tmp = a
    a = b
    b = tmp
}


// MARK: - Generic Type (泛型类型)

struct IntStack {
    var items = [Int]()
    
    mutating func push(_ item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
}


struct Stack<Element> {
    var items = [Element]()
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

// Extending a Generic Type
extension Stack {
    var topItem: Element? {
        return items.first
    }
}


func test_stack() {
    var stringStack = Stack<String>()
    stringStack.push("1")
    stringStack.push("2")
    stringStack.push("3")
    
    
    var intStack = Stack<Int>()
    intStack.push(1)
    intStack.push(2)
    intStack.push(3)
}


// MARK: - Type Constraints (类型约束)

/*
 类型约束是指泛型类型需要继承特定的类型或者遵循特定的协议。
 
 */
// 语法
func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    // function body goes here
}

// 该函数只适用String类型
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

/*
 函数中需要执行 == 运算符，然而，在swift中，并不是所有的类型都可以进行 == 运算，
 只有遵循 Hashable 协议的类型才能；所以泛型类型T必须遵循Hashable协议， 即 T: Hashable
 */

func findIndex<T: Hashable>(ofValue valueToFind: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}


// MARK: - Associated Types (关联类型泛型)


protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

// conformance to the Container protocol
extension IntStack: Container {
    
    typealias Item = Int
    mutating func append(_ item: Int) {
        items.append(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
}

extension Stack: Container {
    
    typealias Item = Element // 这行是可选的
    mutating func append(_ item: Element) {
        items.append(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Element {
        return items[i]
    }
}



// Adding Constraints to an Associated Type
protocol ContainerHashable {
    associatedtype Item: Hashable
    mutating func hash_append(_ item: Item)
    var hash_count: Int { get }
}

extension Stack: ContainerHashable where Element: Hashable {
    typealias item = Element // 这行是可选的
    
    mutating func hash_append(_ item: Element) {
        items.append(item)
    }
    
    var hash_count: Int {
        return items.count
    }
}


// Using a Protocol in Its Associated Type’s Constraints
protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}
