//
//  UnsafePointer.swift
//  SyntaxDemo
//
//  Created by Knox on 2020/11/21.
//  Copyright © 2020 luoquan. All rights reserved.
//

import Foundation

// https://www.jb51.net/article/103538.htm

func unsafePointer_entry() {
    
//    test_UnsafeMutalRawPointer()
//    test_UnsafeMutablePointer()
//    test_rawPointer2TypePointer()
    test_withUnsafeBytes()
}


fileprivate struct Sample {
    var number: Int
    var flag: Bool
}


func test_UnsafeMutalRawPointer() {
    let intStride = MemoryLayout<Int>.stride
    let intAlignment = MemoryLayout<Int>.alignment
    let byteCount = intStride * 5
    let pointer = UnsafeMutableRawPointer.allocate(byteCount: byteCount, alignment: intAlignment)
    defer {
        // 手动释放内存
        pointer.deallocate()
    }
    
    let storedValue = 0x1fffffffffffff7f
    pointer.storeBytes(of: storedValue, as: Int.self)
    let value = pointer.load(fromByteOffset: 0, as: Int8.self)
    
    print("value = \(value)")
    
    
    
    let p1 = UnsafeMutableRawPointer.allocate(byteCount: intStride * 10, alignment: intAlignment)
    let intp1 = p1.initializeMemory(as: Int.self, repeating: 10, count: 5) // 返回 UnsafeMutableBufferPointer<Int>
    print(intp1.pointee)
    let intp2 = p1.bindMemory(to: Int.self, capacity: 5) //  UnsafeMutablePointer<Int>
    print(intp2.pointee)
}


func test_UnsafeMutablePointer() {
//    UnsafeMutablePointer带类型的MutableRawPoint
    let p1 = UnsafeMutablePointer<Int>.allocate(capacity: 10)
    p1.initialize(repeating: 2, count: 10)
    defer {
        p1.deallocate()
    }
    
    for i in 0..<4 {
        let tmp = p1 + i;
        tmp.initialize(to: i * 10)
        print(tmp.pointee)
    }
}

func test_rawPointer2TypePointer() {
    let rawPointer = UnsafeMutableRawPointer.allocate(byteCount: 80, alignment: 8)
    defer {
        rawPointer.deallocate()
    }
    let count = 10;
    let typePointer = rawPointer.bindMemory(to: Int.self, capacity: count)
    typePointer.initialize(repeating: 16, count: count)
    defer {
        typePointer.deinitialize(count: count)
    }
    
    typePointer.pointee = 1
    typePointer.advanced(by: 1).pointee = 2
    
    let bufferPointer = UnsafeBufferPointer(start: typePointer, count: count)
    
    for (index, value) in bufferPointer.enumerated() {
        print("value: \(index):\(value)")
    }
}


func test_withUnsafeBytes() {
    var ins = Sample(number: 10, flag: true)
    withUnsafeBytes(of: &ins) { rawBuffer in
        for byte in rawBuffer {
            print(byte)
        }
    }
}
