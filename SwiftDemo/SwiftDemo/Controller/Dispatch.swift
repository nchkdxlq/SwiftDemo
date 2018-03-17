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
//        semaphore()
        createQueue()
    }
    
    
    //MARK: - getQueue
    
    static func getQueue() {
        // 1. main queue
        let main = DispatchQueue.main
        print(main)
        
        // 2. global queue
        let qos = DispatchQoS.QoSClass.background // 设置队列的优先级
        let global = DispatchQueue.global(qos: qos)
        print(global)
    }
    
    
    //MARK: - createQueue
    
    static func createQueue() {
//        createSerialQueue()
        createConcurrentQueue()
    }
    
    static func createSerialQueue() {
        let serialQueue = DispatchQueue(label: "com.swiftDemo")
        
        print("--- 1111 ----")
        
        for i in 0..<10 {
            serialQueue.async {
                print("\(Thread.current) ---- : \(i) serial.async")
            }
        }
        
        // ... 任务
        var j = 0
        while j < 1000000 {
            j = j + 1
        }
        print("--- 2222 ----")
        
        // ... 任务
        
        for i in 0..<10 {
            serialQueue.sync(execute: {
                print("\(Thread.current) ---- : \(i) serial.sync")
            })
        }
        
        print("--- 3333 ----")
        
        /*
         1. 1111、2222、3333的相对顺序是固定的
         2. (i) serial.async 顺序是固定的，  (0) serial.async 到 (9) serial.async
         3. (i) serial.sync 顺序是固定的， (0) serial.sync 到 (9) serial.sync
         4. (i) serial.async 一定在 (i) serial.sync 前面
         5. (i) serial.sync 一定在 2222 后面， 在 3333 的前面。
         6. 2222 可能在 (i) serial.async 后面， 也可能在 2222 的前面。
            6.1) 当 2222 前面有还耗时任务时，2222 就在 (i) serial.async 后面， 例如有while循环
            6.2) 当 2222 前面有还耗时任务时，2222 就在 (i) serial.async 之前。
         */
    }
    
    
    static func createConcurrentQueue() {
        let concurrentQueue = DispatchQueue(label: "com.swift", qos: .default, attributes: .concurrent)
        
        print("--- 1111 ----")
        
        for i in 0..<10 {
            concurrentQueue.async {
                print("\(Thread.current) ---- : \(i) concurrent.async")
            }
        }
        
        // ... 任务
        var j = 0
        while j < 1000000 {
            j = j + 1
        }
        print("--- 2222 ----")
        
        // ... 任务
        
        for i in 0..<10 {
            concurrentQueue.sync(execute: {
                print("\(Thread.current) ---- : \(i) concurrent.sync")
            })
        }
        
        print("--- 3333 ----")
        
        /*
         1. 1111、2222、3333的相对顺序是固定的
         2. 因为是并发队列异步任务， 所以各个 (i) concurrent.async 执行顺序是交叉进行的，执行的顺序不确定
         3. 因为是同步任务，等一个任务执行完之后再执行下一个任务，所有 (i) concurrent.sync 是固定的
         4. (i) concurrent.async 与 (i) concurrent.sync 可能交替执行
         
         */
    }
    
    
    //MARK: - workItem
    
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
    
    //MARK: - group
    
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
    
    //MARK: - semaphore
    
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
