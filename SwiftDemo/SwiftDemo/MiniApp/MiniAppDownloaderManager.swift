//
//  MiniAppDownloaderManager.swift
//  SwiftDemo
//
//  Created by Knox on 2022/4/5.
//  Copyright © 2022 luoquan. All rights reserved.
//

import Foundation

class MiniAppDownloaderManager {

    let queue: OperationQueue
    
    init() {
        queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .userInitiated
    }
    
    func download(miniApps: [MiniApp]) {
        
    }
    
}
