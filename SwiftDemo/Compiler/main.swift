//
//  main.swift
//  Compiler
//
//  Created by Knox on 2020/6/19.
//  Copyright © 2020 luoquan. All rights reserved.
//

import Foundation





func lexer() {
    //let code = "int age = 45"
    //let code = "age >= 45"
    let code = "2+3*5"

    let lexer = Lexer()
    _ = lexer.tokenize(code: code)

    print(lexer.tokens)
}

func calculator_entry() {
    var code = "int a = b+3;"
    code = "2+3*5*2"
    code = "2+3+4"
    let calculator = Calculator()
    let result = calculator.evaluate(code: code)
    print("\nresult = \(result) \n")
}

//calculator_entry()


scriptParser()


