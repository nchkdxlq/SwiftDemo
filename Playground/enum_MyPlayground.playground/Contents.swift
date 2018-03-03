//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


/* 枚举的定义：
 定义：为一组相关值定义了通用类型，可以在代码中类型安全的操作这些值。
*/

enum StudentType: Int {
    case pupil = 10
    case middleSchoolStudent = 20
    case collecgeStudent = 24
}

let type = StudentType.pupil

/* 原始值 raw value
 
 枚举成员可以用相同类型的默认值预先填充，这样的值我们称之为原始值
 可以使用成员的rawValue 属性来访问成员的原始值， 
 也可以使用原始值利用枚举的初始化枚举成员。
 注意： Int 修饰的是枚举StudentType原始值的类型，不是StudentType的类型，
    枚举StudentType就是一个全新的数据类型
 
 */

let pupleRaw = type.rawValue
let middle = StudentType(rawValue: 20)

/*
 隐式指定原始值
 当原始值的类型为 Int 或者 String 的时候，你可以不必显示的给每一个成员
 都分配一个原始值。当你没有分配时，Swift将会自动为你分配值。
 
 实际上，当 Int 值被作为原始值时，每个成员的隐式都比前一个大一，如果第一个成员没有提供原始值，那么它的值为0
 
 */


/* 用整型原始值代表从太阳到每个行星的顺序， mercury有明确的原始值1,venus的隐式原始值为2，以此类推。 */
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturen, uranus, nepune
}


/* 用字符串作为原始值的类型
 当用字符串作为原始值的类型时，那么每一个成员的隐式原始值就是那个成员的名称
 */

enum CompassPoint: String {
    case north, south, east, west
}

// CompassPoint.north的原始值就是 "north"



/*
 关联值 associated value
 
 */





