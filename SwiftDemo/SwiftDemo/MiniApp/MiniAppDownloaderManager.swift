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
        for app in miniApps {
            let downloadTask = MiniAppDowloadTask(app)
            downloadTask.completionBlock = { [unowned self] in
                downloadDidFinish(downloadTask)
            }
            queue.addOperation(downloadTask)
        }
    }
    
    func downloadDidFinish(_ downloadTask: MiniAppDowloadTask) {
        if downloadTask.state == .failed {
            if downloadTask.retryCount < 3 {
                queue.addOperation(downloadTask)
            } else {
                // 重试失败, 丢弃不在重试
            }
        } else if downloadTask.state == .success {
            // 保存db
        }
    }
}
