//
//  Singleton.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 2016/10/18.
//  Copyright © 2016年 nchkdxlq. All rights reserved.
//

import UIKit

class Singleton: NSObject {
    
//    class func shareInstance() -> Singleton {
//        struct Static {
//            static var onceToken: dispatch_once_t = 0
//            static var staticInstance: Singleton?
//        }
//        
//    }
    
    // 单行单例， 必须保证初始化方法为私有的，避免其他类通过单例类初始化额外的实例。
    static let getInstance = Singleton()
    private override init() {}
    
    
}
