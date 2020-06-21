//
//  ASTNode.swift
//  Compiler
//
//  Created by Knox on 2020/6/20.
//  Copyright © 2020 luoquan. All rights reserved.
//

import Foundation

class ASTNode {
    
    private (set) var type: ASTNodeType
    
    // 文本值
    var text = ""
    
    
    private (set) var children = [ASTNode]()
    
    var parent: ASTNode?
    
    
    init(type: ASTNodeType) {
        self.type = type
    }
    
    init(type: ASTNodeType, text: String) {
        self.type = type
        self.text = text
    }
    
    var childrenCount: Int {
        return children.count
    }
    
    var isTerminal: Bool {
        return children.count == 0
    }
    
    // 是否是命名节点
    var isNamedNode: Bool {
        return type != .undefined
    }
    
    // 添加子节点的时候，如果子节点不是命名节点，直接把它的下级节点加进来。这样简化了AST。
    func addChild(_ child: ASTNode) {
        if child.isNamedNode {
            children.append(child)
            child.parent = self
        } else {
            // 当child的子节点都加到当前结点
            children.append(contentsOf: child.children)
            child.children.forEach { $0.parent = self }
        }
    }
    
}



enum ASTNodeType: String {
    case undefined
    case programm          //程序入口，根节点

    case intDeclaration     //整型变量声明
    case expressionStmt     //表达式语句，即表达式后面跟个分号
    case assignmentStmt     //赋值语句

    case primary            //基础表达式
    case multiplicative     //乘法表达式
    case additive           //加法表达式

    case identifier         //标识符
    case intLiteral          //整型字面量
}
