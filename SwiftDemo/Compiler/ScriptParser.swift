//
//  ScriptParser.swift
//  Compiler
//
//  Created by Knox on 2020/6/28.
//  Copyright © 2020 luoquan. All rights reserved.
//

import Foundation



func scriptParser() {
    
    let calculator = Calculator()
    var script = ""
    
    while true {
        print("> ", separator: "", terminator: "")
        let text = readLine()?.trimmingCharacters(in: CharacterSet.whitespaces) ?? ""
        if text == "exit;" {
            print("good bye!")
            break
        }
        script += text
        
        if script.last == ";" {
            let result = calculator.evaluate(code: script)
            print(result)
        } else {
            print(script)
        }
    }
}
