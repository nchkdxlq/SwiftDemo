//
//  Student.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 5/14/16.
//  Copyright © 2016 nchkdxlq. All rights reserved.
//

import UIKit

class Student {
    
    
    var _name: String?
    var name: String? {
        get {
            return _name;
        }
        
        set {
            _name = newValue
        }
    }
    
    /*
     属性观察器:willSet. didSet
     当属性的值被重新赋值时，会调用一下两个方法
     willSet // 设置新值前调用 willSet 观察器会将新的属性值作为常量参数传入,
            在 willSet 的实现代码中可以为这个参数指定一个名称,
            如果不指定则参数仍然可用,这时使用默认名称 newValue 表示
     didSet // 设置新值后调用,注意：如果在didSet中又修改了属性的值，那么属性的值为修改之后的值
     
     */
    var age: Int {
        
        willSet (newAge) {
            print("newAge = \(newAge)")
        }
        
        didSet {
//            age = 30
            print("didSet")
        }
    
    }
    
    var gender: String? {
        
        didSet {
            print("set gender")
        }
    }
    
    
    init(name: String, age: Int) {
        _name = name
        self.age = age
    }
    
}


/**
 *  结构体类型,结构体属于 ‘值类型’ 的数据类型
 
 1.所有结构体都有一个自动生成的成员逐一构造器,用于初始化新结构体实例中成员的属性。
 新实例中各个属性的初始值可以通过属性的名称传递到成员逐一构造器之中
 
 2.在 Swift 中,所有的结构体和枚举类型都是值类型。这意味着它们的实例,以及实例中所包含的任何值类型属性,
 在代码中值传递的时候都会被复制。（赋值或者函数值传递时， 都会被拷贝）
 
 3.用let声明了一个结构体常量， 就不能修改结构体里面的属性， 因为结构体是值类型；
 如果要改变一个结构体内部的属性，需要将结构体声明为变量 var
 
 */


struct SomeSize {
    var width = 0
    var height = 0
}



/*
 
 枚举也是‘值类型’
 
 
 */

enum CompassPoint {
    case east, south, west, north
}



/*
 属性的定义:
 属性将值跟特定的类、结构体或枚举关联。'存储属性'存储 常量 或 变量 作为实例的一部分,
 而'计算属性'计算(不是存储)一个值。计算属性可以用于类、结构体和枚举,存储属性只能用于类和结构体，不能用于枚举。
 
 1.存储属性
 一个存储属性就是存储在特定 类 或 结构体 的实例里的一个常量或变量。
 存储属性可以是变量存储属性(用关键字 var 定义),也可以是常量存储属性(用关键字 let 定义)
 
 
 2.延迟存储属性 (俗称懒加载)
 延迟存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用 lazy 来标示一个延迟存储属性
 注意: 必须将延迟存储属性声明成变量(使用 var 关键字),因为属性的初始值可能在实例构造完成之后才会得到。
 而常量属性在构造过程完成之前必须要有初始值,因此无法声明成延迟属性。
 
 
 
 3.计算属性
 除存储属性外,类、结构体和枚举可以定义计算属性。计算属性不直接存储值,而是提供一个 getter 和一个可选 的 setter,
 来间接获取和设置其他属性或变量的值。
 
 */


class Persion: NSObject {
    
}




/*
 
 在实例方法中修改值类型(Modifying Value Types from Within Instance Methods)
 结构体和枚举是值类型。一般情况下,值类型的属性不能在它的实例方法中被修改。
 但是,如果你确实需要在某个具体的方法中修改结构体或者枚举的属性,你可以选择 变异(mutating) 这个方 法,然后方法就可以从方法内部改变它的属性;
 并且它做的任何改变在方法结束时还会保留在原始结构中。方法 还可以给它隐含的 self 属性赋值一个全新的实例,这个新实例在方法结束后将替换原来的实例。
 要使用 变异 方法, 将关键字 mutating 放到方法的 func 关键字之前就可以了
 
 */

struct Point {
    var x = 0.0
    var y = 0.0
    
    mutating func addedByX(detalX: Double, detalY: Double) {
        x += detalX
        y += detalY
    }
}



struct Size {
    var width = 0.0
    var height = 0.0
}

/*
 计算属性举例
 */


/*
 point、size 为存储属性
 center 为计算属性
 */
struct Rect {
    var point = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = point.x + size.width/2
            let centerY = point.y + size.height/2
            return Point(x: centerX, y: centerY)
        }
        
        set(newCenter){
            point.x = newCenter.x - size.width
            point.y = newCenter.y  - size.height
        }
    }
}




