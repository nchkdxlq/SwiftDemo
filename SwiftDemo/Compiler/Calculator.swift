//
//  Calculator.swift
//  Compiler
//
//  Created by Knox on 2020/6/20.
//  Copyright © 2020 luoquan. All rights reserved.
//

import Foundation


/*
 解析表达式 `2+3+4`时，计算顺序出现了错误，先计算了3+4。
 
 programm Calculator
     additive +
         intLiteral 2
         additive +
             intLiteral 3
             intLiteral 4

 result = 9
 
 
 
 
 */

class Calculator {
    
    func evaluate(code: String) -> Int {
        // 1. 词法分析
        let tokenReader = lexer(code: code)
        // 2. 语法分析
        let node = programRoot(tokenReader: tokenReader)
        // 3. 求值
        let result = evaluate(node: node, indent: "")
        
        return result
    }
    
    // MARK: - 对某个AST节点求值，并打印求值过程。
    func evaluate(node: ASTNode, indent: String) -> Int {
        
        print(indent + node.type.rawValue + " \(node.text)")
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
            break;
            
        default:
            break
        }
        
        return result
    }
    
    
    // MARK: - 词法分析
    func lexer(code: String) -> TokenReader {
        let lexer = Lexer()
        return lexer.tokenize(code: code)
    }
    
    
    // MARK: - 语法分析
    func programRoot(tokenReader: TokenReader) -> ASTNode {
        let node = ASTNode(type: .programm, text: "Calculator")
        if let child = additive(tokenReader: tokenReader) {
            node.addChild(child: child)
        }
        return node
    }
    
    // MARK: - int声明语句
    func iniDeclare(tokens: TokenReader) -> ASTNode? {
        guard let intToken = tokens.peek() else {
            return nil
        }
        
        var node: ASTNode? = nil
        
        if intToken.type == .int {
            tokens.read() // 消耗掉 int
            // 匹配标识符
            if let idToken = tokens.peek(), idToken.type == .identifier {
                //创建当前节点，并把变量名记到AST节点的文本值中，这里新建一个变量子节点也是可以的
                node = ASTNode(type: .intDeclaration, text: idToken.text)
                
                // 消耗掉标识符
                tokens.read()
                
                if let assignToken = tokens.peek(), assignToken.type == .assignment {
                    tokens.read() // 消耗掉等号
                    if let child = additive(tokenReader: tokens) { // 匹配一个表达式
                        node?.addChild(child: child)
                    } else {
                        print("invalide variable initialization, expecting an expression")
                    }
                }
                
            } else {
                print("variable name expected")
            }
        }
        
        if node != nil {
            if let semiToken = tokens.peek(), semiToken.type == .semiColon {
                tokens.read()
            }
        } else {
            print("invalid statement, expecting semicolon")
        }
        
        return node
    }
    
    
    // MARK: - 加法表达式
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
