//: Playground - noun: a place where people can play

import UIKit


let number: Int? = Optional.some(43)
let noNumber: Int? = Optional.none


let imagePaths = ["star": "/glyphs/star.png",
                  "portrait": "/images/content/portrait.jpg",
                  "spacer": "/images/shared/spacer.gif"]


// returns an optional value
let star = imagePaths["star"]

// Optional Binding (可选绑定)
/*
 if let , guard let , switch
 */

if let starPath = imagePaths["star"] {
    print("The star image is at '\(starPath)'")
} else {
    print("Couldn't find the star image")
}

// Optional Chaining (可空链式调用)
/*
 可空链式调用可以安全的访问可选类型的属性和方法，
 如果可选类型为nil时，不会造成运行时错误
 */
if let isPNG = imagePaths["star"]?.hasSuffix(".png") {
    print("The star image is in PNG format")
}

//  Nil-Coalescing Operator ??

let defaultImagePath = "images/default.png"

let heartPath = imagePaths["heart"] ?? defaultImagePath

let possibleNumber: Int? = Int("42")
let possibleSquare = possibleNumber.map { $0 * $0 }
print(possibleSquare)

let noSquare = noNumber.map { $0 * $0 }
print(noSquare)

let possibleSquare1 = possibleNumber.flatMap { x -> Int? in
    let (result, overflowed) = Int.multiplyWithOverflow(x, x)
    return overflowed ? nil : result
}
print(possibleSquare1)


func ??<T>(optional: T?, defaultValue: @autoclosure () -> T) -> T {
    switch optional {
    case .some(let value):
        return value
    case .none:
        return defaultValue()
    }
}

let male = false
let female = true

//let result = male && female


//func &&(lhs: Bool, rhs: @autoclosure () throws -> Bool) rethrows -> Bool {
//    if lhs == false {
//        return false
//    } else {
//        return rhs
//    }
//}




