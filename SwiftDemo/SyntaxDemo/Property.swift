//
//  Property.swift
//  SyntaxDemo
//
//  Created by Knox on 2019/9/22.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation

/*
 ## 存储属性 (Stored Property)
 - 类似于成员变量这个概念
 - 储存在实例变量中
 - 结构体、类可以定义存储属性
 - 枚举`不可以`定义存储属性
 
 注意：在创建`类`和`结构体`的实例时，必须为所有的存储属性设置一个合适的初始值
 
 
 
 ## 计算属性 (Computed Property)
 - 本质是方法
 - 不占用实例的内存
 - 枚举、结构体、类都可以定义计算属性
 - 计算属性只能使用var, 不能使用let
 
 
 */

func property_entry() {
    
//    stored_computed_property()
//    rawValue_entry()
//    lazy_stored_protperty()
    property_observer()
}


func stored_computed_property() {
    struct Circle {
        // 存储属性
        var radius: Double
        
        // 计算属性
        var diameter: Double {
            set {
                radius = newValue / 2
            }
            get {
                radius * 2
            }
        }
    }
    
    let stride = MemoryLayout<Circle>.stride // 分配的内存大小
    print(stride)
    
    var circle = Circle(radius: 5)
    print(circle.radius) // 5.0
    print(circle.diameter) // 10.0
    
    circle.diameter = 12
    print(circle.radius) // 6.0
    print(circle.diameter) // 12.0
}

/*
 枚举原始值rawValue的本质是：只读的计算属性
 */
func rawValue_entry() {
    enum TestEnum: Int {
        case test1 = 1, test2 = 2, test3 = 3
        
        var rawValue: Int {
            switch self {
            case .test1:
                return 11
            case .test2:
                return 22
            case .test3:
                return 33
            }
        }
    }
    
    print(TestEnum.test3.rawValue) // 33
}




/*
 lazy属性必须是var，不能是let
 let必须在实例的初始化方法完成之前就拥有值
 
 如果多条线程同时第一次访问lazy属性，无法保证属性只被初始化一次
 */
func lazy_stored_protperty() {
    
    class Car {
        init() {
            print("Car init")
        }
        
        func run() {
            print("Car is running")
        }
    }
    
    class Person {
        // 第一次使用到的时候才会进行初始化
        lazy var car = Car()
        
        init() {
            print("Person init")
        }
        
        func goOut() {
            print("Person goOut")
            car.run()
        }
    }
    
    let p = Person()
    p.goOut()
    
    
    struct Point {
        var x = 0
        var y = 0
        lazy var z = 0
    }
    
    let point = Point()
    print(point.x)
//    point.z  // 报错， 当结构体定义的延迟属性时，只有用var定义的实例对象才能访问延迟属性， 因为延迟属性初始化时需要改变结构体的内存
}


/*
 - `willSet`会传递新值, 默认叫newValue
 - `didSet`会传递旧值, 默认叫oldValue
 - 在初始化器中设置属性值不会触发`willSet`和`didSet`
 - 在定义属性时设置初始值也不会触发`willSet`和`didSet`
 - 设置的新值和旧值相同时，也会触发`willSet`和`didSet`
 
 */
func property_observer() {
    struct Circle {
        var radius: Double {
            willSet {
                print("willSet", newValue)
            }
            didSet {
                print("didSet", oldValue, radius)
            }
        }
        
        init() {
            self.radius = 10
            print("Circle init!")
        }
    }
    // Circle init!
    var circle = Circle()
    
    // willSet 10.5
    // didSet 10.0 10.5
    circle.radius = 10.5
    // 10.5
    print(circle.radius)
}
