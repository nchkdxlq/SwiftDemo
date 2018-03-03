//: Playground - noun: a place where people can play

import UIKit


let a: UInt8 = 0b00001111
let b = ~a
/*
 ~ 按位取反 bitwise NOT operator
 
 0000 1111  ->   1111 0000
 
 每一位都是按位取反，得到一个新数，具体表示的值有类型决定，不同的类型会得到不同的数值。
 
 */

/*
 补码
 
 负数的二进制表示方法
 负数绝对值得到的数按位取反再加 1 
 例子：
 -16二进制表示
 16的二进制表示 0b 0 0 0 1  0 0 0 0
 按位取反      0b 1 1 1 0  1 1 1 1
 + 1         0b 1 1 1 1  0 0 0 0
 
 */

struct Vector2D {
    var x = 0.0
    var y = 0.0
}

func + (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x+right.x, y: left.y+right.y)
}


let vector1 = Vector2D(x: 10, y: 20)
let vector2 = Vector2D(x: 11, y: 23)
let result = vector1 + vector2


func testFunc() -> Void {
    
}



