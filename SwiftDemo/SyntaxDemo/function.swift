//
//  function.swift
//  SyntaxDemo
//
//  Created by Knox on 2019/7/21.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation



func func_entry() {
    
    var someInt = 3
    
    testInout(&someInt)
//    var anotherInt = 7
//
//    swapTwoInts(&someInt, &anotherInt)
//
//    print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
}


func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let tmp = a
    a = b
    b = tmp
}



func testInout(_ num: inout Int) {
    num = 20
}



var num: Int?  = 10
