//
//  JavaScriptCore.swift
//  SyntaxDemo
//
//  Created by Knox on 2020/6/13.
//  Copyright © 2020 luoquan. All rights reserved.
//

import Foundation
import JavaScriptCore


func javaScriptCore_entry() {
    let context = JSContext()
    guard let ctx = context else { return }
    
    let code = "1 + 2"
    if let result = ctx.evaluateScript(code) {
        print(result);
    }
    
    let funcCode = "(function(x) { return x * x; })"
    if let result = ctx.evaluateScript(funcCode) {
        let arg = JSValue(int32: 2, in: ctx)!
        let num = result.call(withArguments: [arg])!
        print("funcCdoe result = \(num.toInt32())")
    }
    
    
    let promiseCode =
    """
        new Promise(resolve => resolve()).
            then(()=>this.a = 3), function() { return this.a };
    """
    
    if let result = ctx.evaluateScript(promiseCode) {
        let num = result.call(withArguments: [])!
        print("promiseCode result = \(num.toInt32())")
    }
}
