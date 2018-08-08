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
    3. 属性可以是静态属性和实例属性，属性还需要指明是gettable/settable；并不关心是计算属性还是存储属性，这个由遵循协议的类型决定。
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
 
 可以通过实现"指定初始化器"或"便捷初始化器"使遵循协议的类型满足协议初始化要求。
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


// MARK: - Protocol Inheritance (协议继承)

// 遵循协议的类型需要实现"SomeProtocol"和"AnotherProtocol"以及"InheritingProtocol"所有的要求。

protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // protocol definition goes here
}


// MARK: - Class-Only Protocols (只允许类遵循的协议)
// 只要在继承协议列表中添加"AnyObject"即可
protocol SomeClassOnlyProtocol: AnyObject, InheritingProtocol {
    // class-only protocol definition goes here
}

// MARK: - Protocol Composition (协议合并)

protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct Person: Named, Aged {
    var name: String
    var age: Int
}

// 用 & 合并多个协议
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy Birthday, \(celebrator.name), you're \(celebrator.age)!")
}

class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

class City: Location, Named {
    var name: String
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}

func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)")
}

// MARK: - Checking for Protocol Conformance (检查是否遵循某个协议)

func checkingForProtocol() {
    let city = City(name: "shenzhen", latitude: 22.284545, longitude: 114.158656)
    let location = Location(latitude: 22.284545, longitude: 114.158656)
    let objects: [AnyObject] = [city, location]
    
    for item in objects {
        
        // "is" 判断是否遵循了指定协议, 返回true/false
        if item is Named {
            print("conformed Named Protocol")
        }
        
        // "as?", 返回一个可选类型，如果没遵循指定协议，则返回nil
        if let name = item as? Named {
            print("\(name.name)")
        }
        
        // "as!" 强制转换为指定类型，如果实际上不是指定类型，则会出现运行时错误
        let name = item as! Named
        print("\(name.name)")
    }
}


// MARK: - Optional Protocol Requirements






