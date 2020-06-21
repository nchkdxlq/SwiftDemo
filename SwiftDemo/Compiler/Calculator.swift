//
//  Calculator.swift
//  Compiler
//
//  Created by Knox on 2020/6/20.
//  Copyright © 2020 luoquan. All rights reserved.
//

import Foundation


class Calculator {
    
    
    func evaluate(code: String) -> Int {
        let node = parse(code: code)
         return evaluate(node: node, indent: "")
    }
    
    // 对某个AST节点求值，并打印求值过程。
    func evaluate(node: ASTNode, indent: String) -> Int {
        var result = 0
        
        switch node.type {
        case .programm:
            for child in node.children {
               result = evaluate(node: child, indent: indent + "\t")
            }
            
            break
        case .additive:
            let child1 = node.children[0]
            let value1 = evaluate(node: child1, indent: indent + "\t")
            let child2 = node.children[1]
            let value2 = evaluate(node: child2, indent: indent + "\t")
            if node.text == "+" {
                return value1 + value2
            } else {
                return value1 - value2
            }
        case .multiplicative:
            let child1 = node.children[0]
            let value1 = evaluate(node: child1, indent: indent + "\t")
            let child2 = node.children[1]
            let value2 = evaluate(node: child2, indent: indent + "\t")
            if node.text == "*" {
                return value1 * value2
            } else {
                return value1 / value2
            }
        case .intLiteral:
            result = Int(node.text)!
        default:
            break
        }
        
        return result
    }
    
    
    func parse(code: String) -> ASTNode {
        let lexer = Lexer()
        let tokenReader = lexer.tokenize(code: code)
        return programRoot(tokenReader: tokenReader)
    }
    
    
    // MARK: - 语法分析
    func programRoot(tokenReader: TokenReader) -> ASTNode {
        let node = ASTNode(type: .programm, text: "Calculator")
        if let child = additive(tokenReader: tokenReader) {
            node.addChild(child: child)
        }
        return node
    }
    
    
    private func additive(tokenReader: TokenReader) -> ASTNode? {
        guard let child1 = multiplicative(tokenReader: tokenReader) else {
            return nil
        }
        guard var token = tokenReader.peek() else {
            return child1
        }
        
        var node = child1
        if token.type == .plus || token.type == .minus {
            token = tokenReader.read()!
            if let child2 = additive(tokenReader: tokenReader) {
                node = ASTNode(type: .additive, text: token.text)
                node.addChild(child: child1)
                node.addChild(child: child2)
            } else {
                print("invalid additive expression, expecting the right part.")
            }
        }
        
        return node
    }
    
    
    // 语法解析：乘法表达式
    private func multiplicative(tokenReader: TokenReader) -> ASTNode? {
        guard let child1 = primary(tokenReader: tokenReader) else {
            return nil
        }
        
        guard var token = tokenReader.peek() else {
            return child1
        }
        
        var node = child1
        if token.type == .star || token.type == .slash {
            token = tokenReader.read()!
            if let child2 = multiplicative(tokenReader: tokenReader) {
                node = ASTNode(type: .multiplicative, text: token.text)
                node.addChild(child: child1)
                node.addChild(child: child2)
            } else {
                print("invalid multiplicative expression, expecting the right part.")
            }
        }
        
        return node
    }
    
    // 语法解析：基础表达式
    private func primary(tokenReader: TokenReader) -> ASTNode? {
        guard var token = tokenReader.peek() else { return nil }
        var node: ASTNode? = nil
        
        switch token.type {
            case .intLiteral:
                token = tokenReader.read()!
                node = ASTNode(type: .intLiteral, text: token.text)
                break
            
            case .identifier:
                token = tokenReader.read()!
                node = ASTNode(type: .identifier, text: token.text)
                break
            case .leftParen:
                 _ = tokenReader.read()
                
                 node = additive(tokenReader: tokenReader)
                 if node != nil {
                    if let tk = tokenReader.peek() {
                        if tk.type == .rightParen {
                            _ = tokenReader.read()
                        }
                    } else {
                        print("expecting right parenthesis")
                    }
                 } else {
                    print("expecting an additive expression inside parenthesis")
                 }
                break
                
            default:
                break
        }
        
        return node
    }
    
}
