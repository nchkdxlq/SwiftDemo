//
//  GenericCommand.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/7/26.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation


class GenericCommand<T> : TMCommandProtocol {
    
    let receiver: T
    let cmdClosure: (T) -> Void
    
    
    init(receiver: T, cmdClosure: @escaping (T) -> Void) {
        self.receiver = receiver
        self.cmdClosure = cmdClosure
    }
    
    
    func execute() {
        cmdClosure(receiver)
    }
    
}
