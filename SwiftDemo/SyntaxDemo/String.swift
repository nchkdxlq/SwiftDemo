//
//  String.swift
//  SyntaxDemo
//
//  Created by Knox on 2019/9/28.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation


func string_entry() {
    // 0x7ffeefbff510: 0x33323130 0x37363534 0x00003938 0xea000000
    let str1 = "0123456789ABCDEF"
    print(MemoryLayout.stride(ofValue: str1))
}
