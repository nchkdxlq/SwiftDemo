//
//  operator.swift
//  Compiler
//
//  Created by Knox on 2020/6/19.
//  Copyright © 2020 luoquan. All rights reserved.
//

import Foundation

enum OperatorType {
    case assign
    case equal
    case greaterThan
    case greaterEqual
    case lessThan
    case lessEqual
}

enum TokenType: String {
    // + - * /
    case plus, minus, star, slash
    // > >= == < <=
    case greaterThan, greaterEqual, equal, lessThan, lessEqual
    // ;
    case semiColon
     // ( )
    case leftParen, rightParen
    // =
    case assignment
    // if else
    case `if`, `else`
    // int
    case `int`
    // 标识符
    case identifier
    // int字面量
    case intLiteral
    // string字面量
    case stringLiteral
}


// 有限状态机的各种状态
enum DfaState {
    case initial
    
    case Id
    
    case If, Id_if1, Id_if2
    
    case `else`, Id_else1, Id_else2, Id_else3, Id_else4
    
    case `int`, Id_int1, Id_int2, Id_int3
    
    case greaterThan // >
    case greaterEqual // >=
    case equal // ==
    
    case assignment // 赋值 =

    case plus, minus, star, slash // + - * /
    
    case semiColon // 分号
    case leftParen // 左圆括号 (
    case rightParen // 右圆括号 )

    case IntLiteral // int字面量
}


