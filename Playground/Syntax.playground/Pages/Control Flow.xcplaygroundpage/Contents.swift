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



// 2019/06/29 [New]
// stride
let minites = 60
let miniteInterval = 5
let __stride = stride(from: 0, to: minites, by: miniteInterval) // 返回一个序列，从start开始，到end结束，但序列中不包含end，序列的步长为stride
for tickMark in __stride {
    // render the tick mark every 5 minutes (0, 5, 10, 15 ... 45, 50, 55)
}


//: ## while

let max = 2

// while, 先判断条件，满足条件后再执行循环语句
var i = 0

while i < max {
    print(i)
    i += 1
}
// 0
// 1


// 2019/06/29 [New]

// repeat while // 先执行循环语句，再判断条件. 相当于C语言中的  do...while
var j = 0
repeat {
    print(j)
    j += 1
} while j < max

// switch

