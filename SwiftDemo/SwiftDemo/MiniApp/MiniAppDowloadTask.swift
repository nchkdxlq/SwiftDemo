//
//  MiniAppDowloadTask.swift
//  SwiftDemo
//
//  Created by Knox on 2022/4/5.
//  Copyright © 2022 luoquan. All rights reserved.
//

import Foundation

enum MiniAppDowloadState {
    case `init`, process, success, failed
}

class MiniAppDowloadTask: Operation, URLSessionDelegate {
    
    let miniApp: MiniApp
    
    /// 当前MiniApp的下载状态
    private(set) var state = MiniAppDowloadState.`init`
    
    /// 重试失败的次数
    private(set) var retryCount = 0
    
    /// 当前下载的差分包
    private var downloadingPkgInfo: MiniAppDiffPackage
   
    
    /// 并发
    override var isConcurrent: Bool {
        return true
    }
    
    private var _isExecuting = false {
        willSet {
            willChangeValue(forKey: #keyPath(Operation.isExecuting))
        }
        didSet {
            didChangeValue(forKey: #keyPath(Operation.isExecuting))
        }
    }
    
    override var isExecuting: Bool {
        return _isExecuting
    }
    
    private var _isFinished = false {
        willSet {
            willChangeValue(forKey: #keyPath(Operation.isFinished))
        }
        didSet {
            didChangeValue(forKey: #keyPath(Operation.isFinished))
        }
    }
    
    override var isFinished: Bool {
        return _isFinished
    }
    
    private lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        return session
    }()
    
    private var task: URLSessionDownloadTask!
    
    init(_ miniApp: MiniApp) {
        self.miniApp = miniApp
        downloadingPkgInfo = miniApp.curPackageInfo
        super.init()
    }
    
    override func start() {
        state = .process
        if isCancelled {
            done()
            return
        }
        
        _isExecuting = true
        fetchDownloadURL()
    }
    
    private func fetchDownloadURL() {
        let fid = "xx"
        // 通过fid获取下载链接
        
        // 已获取到URL
        let urlStr = "";
        guard let url = URL(string: urlStr) else {
            state = .failed
            done()
            return;
        }
        downloadMiniApp(url: url)
    }
    
    
    private func downloadMiniApp(url: URL) {
        let request = URLRequest(url: url)
        let destPath = NSTemporaryDirectory() + "/\(UUID().uuidString).zip"
        let fileManager = FileManager.default
        
        
        // 1. 验证
        if isCancelled {
            done()
            return
        }
        
        // 2. 解压缩
        if isCancelled {
            done()
            return
        }
        
        // 3. 写入
        if isCancelled {
            done()
            return
        }
        
        let packgePath = ""
        let appHomePath = ""
        let success: Bool
        if downloadingPkgInfo.isDiffPackage {
            success = updatePackageUseDiffPackage(packgePath, appHomePath)
        } else {
            success = updatePackageUseFullPackage(packgePath, appHomePath)
        }
        
        if success {
            state = .success
            miniApp.packageVersion = miniApp.version
        } else {
            state = .failed
        }
        done()
    }
    
    private func updatePackageUseFullPackage(_ packagePath: String, _ appHomePath: String) -> Bool {
        let fileManager = FileManager.default
        var success = true
        do {
            // 1. 删除本地已经存在的离线包
            if fileManager.fileExists(atPath: appHomePath) {
                let url = URL(fileURLWithPath: appHomePath)
                try fileManager.removeItem(at: url)
            }
            // 2. 写入新的离线包
            try fileManager.moveItem(atPath: packagePath, toPath: appHomePath)
        } catch {
            // 文件操作失败
            success = false
        }
        return success
    }
    
    private func updatePackageUseDiffPackage(_ packagePath: String, _ appHomePath: String) -> Bool {
        let fileManager = FileManager.default
        var success = true
        do {
            let tmpPath = "\(NSTemporaryDirectory())/\(UUID().uuidString)"
            // 1. 本地离线包先拷贝到一个临时路径
            try fileManager.copyItem(atPath: appHomePath, toPath: tmpPath)
            
            // 2. 遍历差分包文件
            if let subPaths = fileManager.subpaths(atPath: packagePath) {
                for subPath in subPaths {
                    // 在差分包中的路径
                    let filePath = "\(packagePath)/\(subPath)"
                    var isDirectory: ObjCBool = false
                    if fileManager.fileExists(atPath: filePath, isDirectory: &isDirectory) {
                        if isDirectory.boolValue {
                            // do nothing
                        } else {
                            // MiniApp临时离线包目录中
                            let filePathAtApp = "\(tmpPath)/\(subPath)"
                            if fileManager.fileExists(atPath: filePathAtApp) {
                                try fileManager.removeItem(atPath: filePathAtApp)
                            }
                            // 2.1 把差分包中的单个文件移动到MiniApp临时离线包目录中
                            try fileManager.moveItem(atPath: filePath, toPath: filePathAtApp)
                        }
                    }
                }
            }
            
            // 3. 差分包文件已全部移动到MiniApp临时目录中, 用临时目录替换MiniApp离线包目录
            try _ = fileManager.replaceItemAt(URL(fileURLWithPath: appHomePath), withItemAt: URL(fileURLWithPath: tmpPath))
        } catch {
            // 文件操作失败
            success = false
        }
        return success
    }
    
    
    private func done() {
        _isExecuting = false
        _isFinished = true
    }
}
