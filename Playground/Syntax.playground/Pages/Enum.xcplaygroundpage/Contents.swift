//: [Previous](@previous)

import Foundation

//: [Next](@next)

/*
    1. 基本语法
    2. 关联值
    3. 原始值
        1) 隐式类型原始值 Int， String
    4. 递归枚举
 */


//: 语法
enum CompassPoint {
    case north
    case south
    case east
    case west
}


// 使用switch语句匹配枚举值

let dictionToHead = CompassPoint.south

switch dictionToHead {
case .north:
    print("Lost of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the skies are rires")
case .west:
    print("Where the skies are blue")
}

// 迭代便利枚举值

enum Beverage: CaseIterable {
    case coffee, tea, juice
}

let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")

// 关联值

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)

productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

switch productBarcode {
case .upc(let numberSystem, let manufactuerer, let product, let check):
        print("UPC: \(numberSystem), \(manufactuerer), \(product), \(check)")
case .qrCode(let code):
        print("QR code: \(code)")
}

// 如果关联值都定义为常亮或者变量，可以把let/var放到枚举名称的前面
switch productBarcode {
case let .upc(numberSystem, manufactuerer, product, check):
    print("UPC: \(numberSystem), \(manufactuerer), \(product), \(check)")
case .qrCode(let code):
    print("QR code: \(code)")
}

// 如果不需要其中的某个关联值，可以使用 _ 忽略它
switch productBarcode {
case let .upc(numberSystem, _, _, _):
    print("UPC: \(numberSystem)")
case .qrCode(let code):
    print("QR code: \(code)")
}

// 原始值 （Raw Values）

enum PokerSuit : Character {
    case spade = "1"
    case heart = "2"
}

// 隐式原始值 （Implicitly Assigned Raw Values）
/*
 如果枚举值的原始值类型时Int, String， Swift会自动分配原始值

 */

// 原始值类型为Int, 第一个case的原始值默认为0， 也可以具体指定，后序case，原始值就递增
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}


// 原始值类型为String, 那么每个case的原始值默认为case的名称
enum Direction: String {
    case north, south, east, west
}

print(Direction.north)
// north

// 等价于下面的写法
/*
enum Direction: String {
    case north = "north"
    case south = "south"
    case east = "east"
    case west = "west"
}
*/


print(Direction.north) // north
print(Direction.north.rawValue) // north


enum Season: Int {
    case spring, summer, autumn, winter
}


// 2019/06/30 [New]
//: ## 递归枚举 （Recursive Enumeration）
/**
    枚举中的case的关联值的类型就是该枚举类型, 需要在具体的case前面使用关键字 indirect 声明， 也可以放在整个枚举的前面
 */


enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

/*
     indirect enum ArithmeticExpression {
         case number(Int)
         case addition(ArithmeticExpression, ArithmeticExpression)
         case multiplication(ArithmeticExpression, ArithmeticExpression)
     }
 */

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))


func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))
// Prints "18"


//: ## MemoryLayout

let age = 20

MemoryLayout<Int>.size
MemoryLayout<Int>.stride
MemoryLayout<Int>.alignment


MemoryLayout.size(ofValue: age)




enum Password {
    case number(Int, Int, Int, Int)
    case other
}

MemoryLayout<Password>.size
MemoryLayout<Password>.stride
MemoryLayout<Password>.alignment

var pwd = Password.number(1, 2, 3, 4)


