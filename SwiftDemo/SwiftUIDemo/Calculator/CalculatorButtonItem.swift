//
//  CalculatorButtonItem.swift
//  SwiftUIDemo
//
//  Created by luoquan on 2022/10/20.
//  Copyright © 2022 luoquan. All rights reserved.
//

import Foundation

enum CalculatorButtonItem {
    
    enum Op: String {
        case plus = "+"
        case minus = "-"
        case divide = "/"
        case multiply = "×"
        case equal = "="
    }
    
    enum Command: String {
        case clear = "AC"
        case flip = "-/+"
        case percent = "%"
    }
    
    case digit(Int)
    case dot
    case op(Op)
    case command(Command)
}

extension CalculatorButtonItem: Hashable {}

extension CalculatorButtonItem {
    
    var title: String {
        switch self {
        case .digit(let value): return String(value)
        case .dot: return "."
        case .op(let op): return op.rawValue
        case .command(let cmd): return cmd.rawValue
        }
    }
    
    var size: CGSize {
        if case .digit(let value) = self, value == 0 { // 模式匹配
            return CGSize(width: 88 * 2 + 8, height: 88)
        } else {
            return CGSize(width: 88, height: 88)
        }
    }
    
    var backgroundColorName: String {
        switch self {
        case .digit, .dot: return "digitBackground"
        case .op: return "operatorBackground"
        case .command: return "commandBackground"
        }
    }
}
