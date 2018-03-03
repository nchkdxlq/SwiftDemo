//: Playground - noun: a place where people can play

import UIKit

enum CompassPoint: String {
    case North
    case South
    case East
    case West
}


var directionToHead = CompassPoint.West

let directionToHeadHaseValue = directionToHead.hashValue
let directionToHeadRawValue = directionToHead.rawValue

enum Gender: String {
    case male = "1"
    case female = "2"
}

// rawValue 与 hashValue 的区别
let sex = Gender.female
let rawValue = sex.rawValue
let hashValue = sex.hashValue

let testSex = Gender(rawValue: "2")




enum Barcode {
    case Upc(Int, Int, Int, Int)
    case QrCode(String)
}


var productBarcode = Barcode.Upc(8, 85909, 51226, 3)








