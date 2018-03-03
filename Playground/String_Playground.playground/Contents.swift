//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


let startIndex = str.startIndex
let toIndex = str.index(startIndex, offsetBy: 5)
let subStr1 = str.substring(to: startIndex)

let C = str[startIndex]
let view = String.CharacterView(str)
str.characters

let num: Int = 1




/////////////////////////////////////////////




func sumNum(_ num: Int) -> Int {

    var sum = 0
    
    for i in 1...num {
        let a = sum + i
        sum = a
    }
    
    return sum
}


let sum = sumNum(10)















