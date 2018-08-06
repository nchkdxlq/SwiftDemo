//
//  Array.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/8/2.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation


func arrayEntry() {
    
    var pages = [10, 2, 4, 23, 10, 49]
    pages.append(25)
    
    for item in pages {
        print("\(item)")
    }
    
    for (index, item) in pages.enumerated() {
        print("\(index) : \(item)")
    }

    let mapPages = pages.map { (item) -> Int in
        return item + 1
    }
    print(mapPages)
    
    let mapPages2 = pages.map{ $0 + 2 }
    print(mapPages2)
    
    let ret = pages.reduce(10) { (ret, item) -> Int in
        return ret + item
    }
    print("ret = \(ret)")
    
    _ = pages.prefix(2)
    if let index = pages.index(of: 10) {
        let removeRet = pages.remove(at: index)
        print("\(removeRet)")
    }
}


