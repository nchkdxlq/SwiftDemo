//: Playground - noun: a place where people can play

import UIKit



// 协议对属性的规定
/*
 协议可以规定其遵循者提供特定的名称和类型的'实例属性(instance property)'或者'类属性(type property)',
 不需要指定是存储属性(stored property)还是计算属性(calculate property), 此外还必须声明是只读的还是可读可写的
 
 1.类属性 (type property)
 声明类属性是，需要在使用 static 关键字作为前缀。协议的遵循者是一个类时，可以使用 class 或 static 关键字来声明类属性，
 结构体和枚举只能用static, 但是协议的定义是，仍然要用 static 关键字。
 */

// 1. type Property
protocol SomeProtocol_1 {
    static var fullName: String? {get set}
}

// 2. instance property
protocol SomeProtocol_2 {
    var sayHello: String {get}
}

class TestPersonClass: NSObject, SomeProtocol_1 {
    // 可以使用class 或者 static 关键字来声明type property
    //    class var fullName: String?
    static var fullName: String? {
        get {
            return self.fullName
        }
        
        set {
            self.fullName = newValue
        }
    }
}

struct LuoPerson: SomeProtocol_1, SomeProtocol_2{
    var name: String?
    var age: Int = 0
    // 类只能用 static 关键字
    static var fullName: String? {
        get{
            return self.fullName
        }
        set{
            self.fullName = newValue
        }
    }
    
    var sayHello: String {
        get {
            return "hello"
        }
    }
}

let person = LuoPerson()
person.sayHello


/*******************************************************************/

// 对方法的规定
/*
 
 协议可以要求其遵循者实现某些指定的实例方法(instance Method)或者类方法(type Method),
 这些方法作为协议的一部分，像普通方法一样放在协议的定义中，但是不需要大括号和方法体。
 在协议的方法定义中，不支持参数默认值。
 
 定义类方法，用static 关键字作为前缀，
 在类中实现时可以使用class 或 static 来实现类方法， 在结构体或者枚举中只能用static
 
 
 */

protocol SomthProtocol_3 {
    // type method
    static func someTypeMethod()
    // instance method
    func someInstanceMethod()
}



protocol RandomNumGenerator {
    func random() -> Double
}

class LinerCongruentialGenerator: RandomNumGenerator {
    func random() -> Double {
        return Double(arc4random() % 10) / 10.0
    }
}

let generator = LinerCongruentialGenerator()
generator.random()
generator.random()
generator.random()


/****************************************************************/

// 对Mutating方法的规定
/*
 有时候需要在方法中改变它的实例。例如，值在类型（结构体、枚举)的实例方法中，将mutating关键字
 作为函数的前缀，写在func之前，表示可以在该方法中修改它所属的实例以及其实例属性的值
 
 如果你在协议中定义了一个方法旨在改变遵循该协议的实例,那么在协议定义时需要在方法前加mutating关键字。
 这使得结构和枚举遵循协议并满足此方法要求。
 
 注意：
 用类实现协议中的mutating方法时，不用写mutating关键字，用结构体、枚举实现协议中mutating方法时，
 必须写mutating关键字
 
 
 */

/*
 定义一个协议，用来改变遵循协议的实例的属性， 来切换遵循该协议的实例的状态
 */
protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    init() {
        self = .off
    }
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

var onOff = OnOffSwitch()
onOff.toggle()
onOff.toggle()



//MARK: Swift Libriry Protocol

//MARK: Equable


struct StreetAddress {
    var number: String
    var name: String
    var unit: String?
    
    init(number: String, name: String, unit: String? = nil) {
        self.number = number
        self.name = name
        self.unit = unit
    }
}


extension StreetAddress: Equatable {
    static func ==(lhs: StreetAddress, rhs: StreetAddress) -> Bool {
        return  lhs.name == rhs.name &&
                lhs.number == rhs.number &&
                lhs.unit == rhs.unit
    }
}

let address1 = StreetAddress(number: "100", name: "固戍一路")
let address2 = StreetAddress(number: "101", name: "固戍一路")
let address3 = StreetAddress(number: "101", name: "固戍二路")
let addrArr = [address1, address2, address3]


let checkAddr = StreetAddress(number: "100", name: "固戍一路")

if addrArr.contains(checkAddr) {
    print("contains")
} else {
    print("no contains")
}












