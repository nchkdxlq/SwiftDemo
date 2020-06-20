//
//  main.swift
//  Compiler
//
//  Created by Knox on 2020/6/19.
//  Copyright © 2020 luoquan. All rights reserved.
//

import Foundation


//let code = "int age = 45"
//let code = "age >= 45"
let code = "2+3*5"

let lexer = Lexer()
lexer.tokenize(code: code)

print(lexer.tokens)
