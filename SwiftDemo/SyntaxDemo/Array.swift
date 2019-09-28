//
//  Array.swift
//  SyntaxDemo
//
//  Created by Knox on 2019/9/28.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation


/*
 1. 1个Array变量占用8个字节内存空间
 2. 数组的元素储存在对空间
 
 数组在堆内存空间的内存分布
 0x10246d240: 0x00007fff97de8750 0x0000000000000002
 0x10246d250: 0x0000000000000004 0x0000000000000008
 0x10246d260: 0x0000000000000001 0x0000000000000002
 0x10246d270: 0x0000000000000003 0x0000000000000004
 0x10246d280: 0x0000000000000000 0x0000000000000000
 
 */
func array_entry() {
    var arr = [1, 2, 3, 4]
    print(MemoryLayout.stride(ofValue: arr)) // 8
    arr.append(5)
}
