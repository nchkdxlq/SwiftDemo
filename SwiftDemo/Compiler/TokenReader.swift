//
//  TokenReader.swift
//  Compiler
//
//  Created by Knox on 2020/6/20.
//  Copyright © 2020 luoquan. All rights reserved.
//

import Foundation

// 用于读取token
struct TokenReader {
    
    private let tokens: [Token]
    private var pos = 0
    
    init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    
    mutating func read() -> Token? {
        var token: Token? = nil;
        if pos < tokens.count {
            token = tokens[pos]
            pos += 1
        }
        return token
    }
    
    // 预读一个token, 如果已经读完，则返回nil
    func peek() -> Token? {
        if pos < tokens.count {
            return tokens[pos]
        }
        
        return nil;
    }
    
    // 回溯一个token
    mutating func unread() {
        if pos > 0 {
            pos -= 1
        }
    }
    
    // get 获取当前指针、set设置指针，用于回溯
    var position: Int {
        get {
            return pos
        }
        set {
            pos = newValue
        }
    }
}
