//: Playground - noun: a place where people can play

import UIKit

/** 
 1. 柯里化 (Currying)
 
 Swift里可以将方法进行柯里化（Currying）,
 将接受多个参数的方法变成只接受第一个参数的方法，
 并且返回接受剩余的参数和返回结果的新方法
 
 */
/* 
函数柯里化：  http://www.jianshu.com/p/6eaacadafa1a
函数式编程：  http://www.ruanyifeng.com/blog/2012/04/functional_programming.html
 */
func addTwoNumbers(_ a: Int) -> (_ num: Int) -> Int {
    return {(num: Int) -> Int in {
            return a + num
        }()}
}

let addToFour = addTwoNumbers(4)

let result = addToFour(6)
print("result = \(result)")



func addThreeNum(_ a: Int) -> (_ b: Int) -> (_ c: Int) -> Int {
    return { (b: Int) -> (_ c: Int) -> Int in {
            return {(c: Int) -> Int in {
                return a + b + c
            }()}
        }()}
}

let sumResult = addThreeNum(10)(20)(30)


/*
 2. Any && AnyObject
 
 Anyobject 可以代表任意 class 类型的实例
 Any 可以表示任意类型，甚至包括方法(func)类型
 
 
 */

func someMethod() -> AnyObject? {
    // 返回一个 AnyObject?，等价于在 Objective-C 中返回一个 id”
    return "cookie" as AnyObject
}


class FloatRef {
    let value: Float
    init(_ value: Float) {
        self.value = value
    }

}

let x = FloatRef(3.14)
let y: AnyObject = x // 作为任意class类型的实例
let z: AnyObject = FloatRef.self // 作为class type

// bridges to Objective-C type 桥接OC数据数据类型

/*
 AnyObject 定义的变量或者常量可以指向 OC的任意class类型的实例(相当于 OC中的 id 类型)
 */
let s: AnyObject = "this is a bridged string." as NSString

let v: AnyObject = 100 as NSNumber
print(type(of: v))

/* 
 Casting AnyObject Instances to a Known Type
 
 类型转换运算符  type-cast operators (`as`, `as?`, or `as!`).
 
 */

if let message = s as? String {
    print("Succesful cast to String: \(message)")
}

if let message = v as? String {
    print("Succesful cast to String: \(message)")
} else {
    print("v can't cast to String.")
}


//let sStr = v as! String   //( triger runtime error )


let swiftInt: Int = 1
let swiftString: String = "cooke"

var array: [AnyObject] = []
array.append(swiftInt as AnyObject)
array.append(swiftString as AnyObject)
print(array)

var array1: [Any] = []
array1.append(swiftInt)
array1.append(swiftString)
print(array1)






