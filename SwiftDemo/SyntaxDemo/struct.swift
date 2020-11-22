//
//  struct.swift
//  SyntaxDemo
//
//  Created by Knox on 2019/7/20.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation


func struct_entry() {
    print("============== struct =============\n")
    testStruct()
    test_point()
}


struct NKPoint {
    var x: Int = 0
    var y: Int = 0
}

func +(lhs: NKPoint, rhs: NKPoint) -> NKPoint {
    return NKPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func +=(lhs: inout NKPoint, rhs: NKPoint) {
    lhs = lhs + rhs
}

extension NKPoint {
    static let origin = NKPoint()
}

struct NKSize {
    var width: Int = 0
    var height: Int = 0
}

struct NKRect {
    var origin: NKPoint
    var size: NKSize
}

/// 通过扩展实现自定义的初始哈方法, 自动生成的成员初始化方法还在
extension NKRect {
    init(x: Int = 0, y: Int = 0, width: Int, height: Int) {
        origin = NKPoint(x: 0, y: 0)
        size = NKSize(width: width, height: height)
    }
    
    // 只有var定义的变量才能调用
    mutating func translate(by offset: NKPoint) {
        origin = origin + offset
    }
}

extension NKRect {
    // 不可变版本的, let定义的变量也可以调用
    func translated(by offset: NKPoint) -> NKRect {
        var copy = self
        copy.translate(by: offset)
        return copy
    }
}



func testStruct() {
    var screen = NKRect(width: 300, height: 400) {
        didSet {
            print("screen changed: \(screen)")
        }
    }
    
    screen.origin.x = 10
}

func test_point() {
    print(#function, "============\n")
    var p = NKPoint.origin
    p += NKPoint(x: 10, y: 20)
    print(p)
}











