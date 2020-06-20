//
//  Token.swift
//  Compiler
//
//  Created by Knox on 2020/6/19.
//  Copyright © 2020 luoquan. All rights reserved.
//

import Foundation


protocol Token {
    var type: TokenType { get }
    var text: String { get }
}


struct SimpleToken: Token {
    var type: TokenType
    var text: String
}

extension SimpleToken: CustomStringConvertible {
    var description: String {
        return "{ \(type.rawValue): \(text) }"
    }
}



