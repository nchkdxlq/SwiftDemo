//
//  Protocol.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/8/6.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation

/*
 协议：定义一系列的方法、初始化器、属性，
    1. 方法可以是静态方法和实例方法；
    2. 初始化器只能是指定初始化器，
       但是在遵循协议的类型可以实现初始化器时，可以是指定初始化器，也可以是便捷初始化器。
    3. 属性可以是静态属性和实例属性，属性还需要指明是gettable/settable。
 */

protocol SomeProtocol {
    
    var mustBeSettable: Int { get set }
    var doesNotNeedSettable: Int { get }
    
    // 静态方法
    static func someTypeMethod()
}


protocol AnotherProtocol {
    
    static var someTypeProperty: Int { get set }
    
}


protocol RandomNumberGenerator {
    
    func random() -> Double
    
}


//MARK: - Mutating Method Requirements

protocol Togglable {
    
    mutating func toggle()
    
}


enum OnOffSwitch: Togglable {
    
    case off, on
    
    mutating func toggle() {
        switch self {
        case .on:
            self = .off
        case .off:
            self = .on
        }
    }
}


class Bulb: Togglable {
    
    var state = false
    
    // 如果遵循协议的是class, 就不需要mutating
    func toggle() {
        state = !state
    }
}

//MARK: - Initializer Requirements

protocol SomeProtocolInit {
    
    init(someParameter: Int)
}

/*
 
 可以通过实现"指定初始化器"或"便捷初始化器"使遵循写协议的类型满足协议初始化要求。
 在两种情况下，必须使用required关键字修饰初始化器实现。
 
 1. 为了保证遵循协议类的所有子类中也有这个初始化器，所以在遵循协议类中协议的初始化器必须使用require关键字，
 如果遵循协议的类已经是final了，就不会有子类了，协议的初始化器实现就不需要用require了。
 
 2. 如果遵循协议类的父类有与协议相同的初始化器，那么实现初始化器时需要 overrider require 关键字。
 */

class SomeClass: SomeProtocolInit {
    
    required convenience init(someParameter: Int) {
        // initializer implementation goes here
        self.init()
    }
    
    init(){}
}

class SomeSuperClass {
    
    init(someParameter: Int) {
        
    }
}

class SomeSubClass: SomeSuperClass, SomeProtocolInit {
    //需要 override required 关键字
    override required init(someParameter: Int) {
        super.init(someParameter: someParameter)
    }
}

// MARK: - Protocols as Types

/*
 尽管协议没有具体的实现，但协议可以作为功能完备的类型在代码中使用。
 居然是类型就可以
 1. 定义变量、常量
 2. 声明属性
 3. 作为函数的参数、返回值
 
 */


// MARK: - Conditionally Conforming to a Protocol
/*
 有条件的遵循协议
 */

protocol TextRepresentable {
    var textualDescription: String { get }
}

// 只有当Element遵循了"TextRepresentable"协议，Array才遵循"TextRepresentable"协议
extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemAsText = self.map{ $0.textualDescription }
        return "[\(itemAsText.joined(separator: ", "))]"
    }
}

// MARK: - Declaring Protocol Adoption with an Extension
/*
 如果一个类型满足了协议的所有要求，可以使用扩展遵循协议。
 说明：一个类型不会因为满足了协议的要求就自动的采纳协议，必须显式地声明采纳了哪个协议。
 */

struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}




