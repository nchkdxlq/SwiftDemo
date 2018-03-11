//
//  Dispatch.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 16/9/25.
//  Copyright © 2016年 nchkdxlq. All rights reserved.
//

import UIKit

class Dispatch: NSObject {
    
    static func dispatchEntry() {
        
//        group()
        semaphore()
    }
    
    static func getQueue() {
        // 1. main queue
        let main = DispatchQueue.main
        print(main)
        
        // 2. global queue
        let qos = DispatchQoS.QoSClass.background // 设置队列的优先级
        let global = DispatchQueue.global(qos: qos)
        print(global)
    }
    
    static func createQueue() {
        
        let customQueue = DispatchQueue(label: "com.swift", qos: .default, attributes: .concurrent)
        print(customQueue)
    }
    
    static func dispatchWorkItem() {
        
        let global = DispatchQueue.global()
        
        let item = DispatchWorkItem {
            print("1111111")
        }
        
        global.async(execute: item)
        global.sync(execute: item)
    }
    
    static func testItemCancel() {
        let item = DispatchWorkItem {
            print("1111111")
        }
        
        item.cancel()
        item.perform()
    }
    
    static func group() {
        let group = DispatchGroup()
        let queue = DispatchQueue.global()
        
        group.enter()
        queue.async {
            print("1111")
            group.leave()
        }
        
        group.enter()
        queue.async {
            print("2222")
            group.leave()
        }
        
        group.notify(queue: queue) {
            print("notify")
        }
    }
    
    static func semaphore() {
        let semaphore = DispatchSemaphore(value: 0)
        
        DispatchQueue.global(qos: .background).async {
            sleep(2)
            print("signal")
            semaphore.signal() // 释放信号
        }
        print("wait 111111")
        semaphore.wait() // 等待/占用信号, 会阻塞
        print("wait 222222")
    }
    
}
