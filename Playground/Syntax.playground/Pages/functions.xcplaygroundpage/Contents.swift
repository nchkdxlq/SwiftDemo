//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


print(str)



func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}


arithmeticMean(1, 2, 3)



func swapTwoInts(_ a: inout Int , _ b: inout Int) {
    let tmp = a
    a = b
    b = tmp
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")







