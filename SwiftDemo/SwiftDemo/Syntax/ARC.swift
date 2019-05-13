//
//  ARC.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/9/13.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation

/*
 Swift通过引用计数的方式对类实例对象进行内存管理。
 */

func arc_test() {
    
    class Person {
        let name: String
        init(name: String) { self.name = name }
        var apartment: Apartment?
        deinit { print("\(name) is being deinitialized") }
    }
    
    class Apartment {
        let unit: String
        init(unit: String) { self.unit = unit }
        var tenant: Person?
        deinit { print("Apartment \(unit) is being deinitialized") }
    }

    var john: Person?
    var unit4A: Apartment?
    
    john = Person(name: "John Appleseed")
    unit4A = Apartment(unit: "4A")
    
    john!.apartment = unit4A
    unit4A!.tenant = john
    
    john = nil
    unit4A = nil
    // 相互引用了，不能释放
}


/*
 1. weak修饰的引用不会是对象的引用计数+1
 2. 当所指的对象被释放后，引用会自动置为nil

 利用weak可以解决对象互相引用造成的循环引用问题。
 */

func weakReference() {
    
    class Person {
        let name: String
        init(name: String) { self.name = name }
        var apartment: Apartment?
        deinit { print("\(name) is being deinitialized") }
    }
    
    class Apartment {
        let unit: String
        init(unit: String) { self.unit = unit }
        weak var tenant: Person?
        deinit { print("Apartment \(unit) is being deinitialized") }
    }
    
    var john: Person?
    var unit4A: Apartment?
    
    john = Person(name: "John Appleseed")
    unit4A = Apartment(unit: "4A")
    
    john!.apartment = unit4A
    unit4A!.tenant = john
    
    john = nil
    
    // 两个对象都释放
}


/*
 1. 不会对对象产生强引用
 2. 当引用的对象被释放时，引用不会置为nil
 3. 需要定位为 nonoptional 类型； unowned var ref = Person()
 使用场景：an unowned reference is used when the other instance has the same lifetime or a longer lifetime .
 
 */
func unownedReference() {
    
    class Customer {
        let name: String
        var card: CreditCard?
        init(name: String) {
            self.name = name
        }
        deinit { print("\(name) is being deinitialized") }
    }
    
    class CreditCard {
        let number: UInt64
        unowned let customer: Customer
        init(number: UInt64, customer: Customer) {
            self.number = number
            self.customer = customer
        }
        deinit { print("Card #\(number) is being deinitialized") }
    }
    
    
    var john: Customer?
    
    john = Customer(name: "John Appleseed")
    john!.card = CreditCard(number: 1234_5678_9012_3456, customer: john!)
    
    john = nil
    // Prints "John Appleseed is being deinitialized"
    // Prints "Card #1234567890123456 is being deinitialized"
}
