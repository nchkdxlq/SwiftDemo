//
//  Lexer.swift
//  Compiler
//
//  Created by Knox on 2020/6/19.
//  Copyright © 2020 luoquan. All rights reserved.
//

import Foundation


class Lexer {
    
    var tokens = [Token]() // 保存解析出来的token
    private var state = DfaState.initial
    private var tokenType = TokenType.identifier
    private var tokenText = ""
    
    func tokenize(code: String) {
        code.forEach(parse)
        parse(Character(" "))
    }
    
    private func parse(_ ch: Character) {
        
        switch state {
        case .initial:
            state = initToken(ch)
            break
            
        case .Id:
            if ch.isNumber || ch.isLetter {
                tokenText.append(ch)
            } else {
                state = initToken(ch)
            }
            break
            
        case .greaterThan:
            if ch == "=" {
                state = .greaterEqual
                tokenText.append(ch)
            } else {
                state = initToken(ch)
            }
            break
            
        case .greaterEqual, .plus, .minus, .star, .slash, .semiColon, .leftParen, .rightParen:
            state = initToken(ch)
        break
        
        case .assignment:
            if ch == "=" {
                state = .equal
            } else {
                state = initToken(ch)
            }
            break
            
        case .IntLiteral:
            if ch.isNumber {
                tokenText.append(ch) //继续保持在数字字面量状态
            } else {
                state = initToken(ch)
            }
            break
            
        case .Id_int1:
            if ch == "n" {
                state = .Id_int2
                tokenText.append(ch)
            } else {
                state = initToken(ch)
            }
            break
            
        case .Id_int2:
            if ch == "t" {
                state = .Id_int3
                tokenText.append(ch)
            } else if ch.isNumber || ch.isLetter { //in1 ina
                state = .Id // 重新回到标识符状态
            } else { // 比如是空格 in =
                state = initToken(ch)
            }
            break
            
        case .Id_int3:
            if ch.isWhitespace { // int =
                tokenType = .int // 识别为 int 类型token
                state = initToken(ch)
            }
            break
            
        default:
            break
        }
        
    }
    
    
    private func initToken(_ ch: Character) -> DfaState {
        if (!tokenText.isEmpty) {
            // 开启一个新的状态，且tokenText不为空，保存token
            let token = SimpleToken(type: tokenType, text: tokenText)
            tokens.append(token)
            
            tokenText = "" // 清空
            tokenType = .identifier
        }
        
        var newState = DfaState.initial
        
        if ch.isLetter { // 第一个字符是字母
            if ch == "i" {
                newState = .Id_int1
            } else {
                newState = .Id
            }
            tokenType = .identifier
            tokenText.append(ch)
        } else if ch.isNumber { // 第一个字符是数字
            newState = .IntLiteral
            tokenType = .intLiteral
            tokenText.append(ch)
        } else if ch == ">" { // 第一个字符是 >
            newState = .greaterThan
            tokenType = .greaterThan
            tokenText.append(ch)
        } else if ch == "+" {
            newState = .plus
            tokenType = .plus
            tokenText.append(ch)
        } else if ch == "-" {
            newState = .minus
            tokenType = .minus
            tokenText.append(ch)
        } else if ch == "*" {
            newState = .star
            tokenType = .star
            tokenText.append(ch)
        } else if ch == "/" {
            newState = .slash
            tokenType = .slash
            tokenText.append(ch)
        } else if ch == ";" {
            newState = .semiColon
            tokenType = .semiColon
            tokenText.append(ch)
        } else if ch == "(" {
            newState = .leftParen
            tokenType = .leftParen
            tokenText.append(ch)
        } else if ch == ")" {
            newState = .rightParen
            tokenType = .rightParen
            tokenText.append(ch)
        } else if ch == "=" {
            newState = .assignment
            tokenType = .assignment
            tokenText.append(ch)
        }
        
        return newState
    }
    
}
