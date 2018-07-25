//
//  Init.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/7/25.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation
import UIKit

/**
 
 初始化是为类、结构体或者枚举准备实例的过程。这个过程需要给实例里的每一个存储属性设置一个初始值，
 并且在新实例可以使用之前执行任何其他所必须的配置或初始化。
 
 */

class InitDemo {
    
    struct Fahrenheit {
        var temperature: Double
        var temp = 32.0 //属性的默认值
        
        init() {
            temperature = 32.0
        }
    }
    
    func fahrenheitDemo() {
        let f = Fahrenheit()
        print("The Default temperatur is \(f.temperature)° Fahrenheit.")
    }
    
    
    // MARK: - 形式参数名和实际参数标签
    
    class Color {
        let red, green, blue: Double
        
        init(red: Double, green: Double, blue: Double) {
            self.red = red
            self.green = green
            self.blue = blue
        }
        
        init(white: Double) {
            self.red = white
            self.green = white
            self.blue = white
        }
    }
    
    func colorDemo() {
        _ = Color(red: 0.5, green: 0.4, blue: 0.3)
        _ = Color(white: 0.1)
    }
    
    
    // MARK: - 可选类型属性
    /*
     当属性的值在初始化的时候不能被设置，或者因为在处理过程中有可能设置为nil,
     属性需要设置为可选类型
     */
    class SurveyQuestion {
        var text: String
        var response: String?
        
        init(text: String) {
            self.text = text
        }
        
        func ask() {
            print(text)
        }
    }
    
    func cheeseQuestionDemo() {
        let cheeseQuestion = SurveyQuestion(text: "Do you like cheese")
        cheeseQuestion.ask()
        cheeseQuestion.response = "Yes, I do line cheese"
    }
    
    
    // MARK: - 初始化分配常量属性的值
    // 在初始化方法中，可以任意修改常量属性的值，只要在初始化结束是确定的值即可。
    class Question {
        let text: String
        var response: String?
        
        init(text: String) {
            self.text = text
        }
        
        func ask() {
            print(text)
        }
    }
    
    func questionDemo() {
        let que = Question(text: "Are you ok")
        que.ask()
    }
    
    
    // MARK: - 默认初始化器
    
    class ShoppingListItem {
        var name: String?
        var quantity = 1
        var purchased = false
    }
    // 由于ShoppingListItem类所有的属性都有默认值，有由于它是一个没有父类的基类，
    // 就自动的有一个默认的初始化方法
    
    func ShoppingListItemDemo() {
        _ = ShoppingListItem()
    }
    
    // MARK: - 结构体类型的成员初始化器
    
    /*
     当结构体没有自定义初始化器，会自动生成一个成员初始化器；只要自定义了初始化器，就不会自动生成。
     */
    
    struct Size {
        var width = 0.0, height = 0.0
    }
    
    func SizeDemo() {
        _ = Size(width: 2.0, height: 2.0)
    }
    
    
    // MARK: - 值类型的初始化器委托
    
    struct Point {
        var x = 0.0, y = 0.0
    }
    
    struct Rect {
        var origin = Point()
        var size = Size()
        
        init() {}
        
        init(origin: Point, size: Size) {
            self.origin = origin
            self.size = size
        }
        
        // 委托初始化器
        init(center: Point, size: Size) {
            let x = center.x - size.width / 2
            let y = center.y - size.height / 2
            self.init(origin: Point(x: x, y: y), size: size)
        }
    }
    
    func RectDemo() {
        _ = Rect()
    }
    
    
    
    // MARK: - 类类型的初始化委托
    
    /*
     
     规则：
     1. 指定初始化器必须调用直系父类的指定初始化器。
     2. 便捷初始化器必须当前类的另一个初始化器。
     3. 便捷初始化器最终必须调用一个指定初始化器。
     
     初始化过程安全检查
     1. 指定初始化器在调用父类的指定初始化器之前，一定要保证当前类新增的属性都初始化完成。
     2. 指定初始化器必须调用父类的指定初始化器
     3. 便捷初始化器只能调用当前类的其他初始化器
     4. 初始化器在第一阶段初始化完成之前，不能调用任何实例方法、
        不能读取任何实例属性的值(还没理解)，也不能引用 self 作为值。
     
     */
    
    class Person {
        var name: String
        var age: Int
        
        init(name: String, age: Int) {
            self.name = name
            self.age = age
        }
        
        convenience init() {
            self.init(name: "zhangsan", age: 20)
        }
    }
    
    class Student: Person {
        var score: Int
        
        init(name: String, age: Int, score: Int) {
            self.score = score
            // self.age = age // ❎
            print(self.score)
            // print(self) // self' used before 'super.init' call
            // display() // self' used in method call 'display' before 'super.init' call
            super.init(name: name, age: age)
            self.age = 20
        }
        
        convenience init(name: String) {
            self.init(name: name, age: 20, score: 60)
        }
        
        convenience init() {
            self.init(name: "laowang", age: 20, score: 60)
        }
        
        func display() {
            print("score = \(score)")
        }
    }
    
    func personDemo() {
        _ = Person()
        _ = Student(name: "lisi")
        let stu1 = Student()
        print(stu1.name)
    }
    
    // MARK: - 初始化器的继承和重写
    
    /*
     初始化器重写：
     如果子类重写了父类的初始化器，子类的初始化器前需要用关键字 override,
     不管父类的初始化器是指定初始化器还是便捷初始化器。
     
     初始化器继承：
     默认情况下，子类不会继承父类的初始化器，满足以下的规则子类会继承父类的初始化器
     
     1. 子类没有定义任何指定初始化器，子类会继承父类所有的指定初始化器,
        只要子类定义了指定初始化器，子类就不会继承任何一个父类的初始化器。
     
     2. 如果子类全部实现了父类的指定初始化器(1.继承父类的指定初始器 2.全部重写父类的初始化器)，
        那么子类会自动的继承父类的所有便捷初始化器。
     
     */
    class Vehicle {
        var numberOfWheels = 0
        var price = 0.0
        var description: String {
            return "\(numberOfWheels) wheel(s)"
        }
        
        init() {}
        
        init(wheels: Int) {
            numberOfWheels = wheels
        }
        
        init(price: Double) {
            self.price = price
        }
        
        convenience init(wheels: Int, price: Double) {
            self.init()
            self.numberOfWheels = wheels
            self.price = price
        }
        
        func display() {
            print(description)
        }
    }
    
    /*
     1. 重写了父类的init初始化器，所以要 override 关键字
     
     */
    class Bicycle: Vehicle {
        var brand = ""
        
        init(brand: String) {
            super.init()
            numberOfWheels = 2
            self.brand = brand
        }
    }
    
    class Car: Vehicle {
        
    }
    
    
    func BicycleDemo() {
        let bicycle = Bicycle(brand: "凤凰牌")
        bicycle.display()
//        let bicycle1 = Bicycle() // 报错，原因参考 规则1
        
        // 能够调用父类的指定初始化器 参考规则1
        let car1 = Car()
        car1.display()
        let car2 = Car(wheels: 4)
        car2.display()
        
        // 能够调用父类的便捷初始化器 参考规则2
        let car3 = Car(wheels: 4, price: 1000)
        car3.display()
    }
    
    //MARK: - 可失败初始化器
    
    //MARK: - 必要初始化器
    
    class SomeClass {
        var name: String
        
        // 初始化器前添加 required.
        required init(name: String) {
            self.name = name
        }
        
        convenience init() {
            self.init(name: "unnamed")
        }
    }
    
    class SomeSubClass : SomeClass {
        // 重写必要初始化器，不需要 override 关键字
        required init(name: String) {
            super.init(name: name)
        }
        
        // 重写父类的初始化器，不需要 override 关键字，因为父类的便捷初始化器不会被子类直接调用。
        convenience init() {
            self.init(name: "san.zhang")
        }
    }
    
}



