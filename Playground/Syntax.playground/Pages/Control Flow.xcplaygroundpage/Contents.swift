//: [Previous](@previous)

import Foundation

//: ## For-In Loops


// iterate Array

let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}


// iterate Dictionary

let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}


// Range
/**
    ... 闭区间运算符, 类型为 ClosedRange<Bound>
 */
let range: ClosedRange<Int> = 1...5
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}


let range1 = 0..<60


// switch

