//
//  Observable.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/8/1.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation

protocol Observer {
    func dataDidUpdate(_ subject: Any)
}

extension Observer {
    func dataDidUpdate(_ subject: Any) {}
}


protocol Subject {
    
    var obs: [Observer] {get set}
    
    func registerObserver(_ ob: Observer)
    func removeObserver(_ ob: Observer)
    func notifyObservers()
}


extension Subject {
    func registerObserver(_ ob: Observer) {}
    func removeObserver(_ ob: Observer) {}
    func notifyObservers() {}
}

