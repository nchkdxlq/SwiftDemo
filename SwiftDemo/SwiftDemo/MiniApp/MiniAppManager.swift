//
//  MiniAppManager.swift
//  SwiftDemo
//
//  Created by Knox on 2022/4/5.
//  Copyright © 2022 luoquan. All rights reserved.
//

import Foundation

class MiniAppManager: NSObject {
    
    static let shared = MiniAppManager()
    
    private let synchronizer = MiniAppSynchronizer()
    private let downloadManager = MiniAppDownloaderManager()
    
    private var activeMiniAppList = [MiniApp]()
    
    func syncMiniApp() {
        let localMiniAppList = [MiniApp]()
        let serverMiniAppList = [MiniApp]()
        
        let deleteApps = filterDeleteMiniApps(localMiniApps: localMiniAppList, serverMiniApps: serverMiniAppList)
        let mergedApps = mergeAndSave(localMiniApps: localMiniAppList, serverMiniApps: serverMiniAppList)
        
        activeMiniAppList.removeAll()
        var dowloadList = [MiniApp]()
        for app in mergedApps {
            if app.state == .open {
                activeMiniAppList.append(app)
            }
            if app.version != app.packageVersion {
                dowloadList.append(app)
            }
        }
        
        // 删除
        delete(miniApps: deleteApps)
        
        // 下载离线包
        downloadManager.download(miniApps: dowloadList)
    }
    
    /// 过滤出下架的MiniApp列表
    private func filterDeleteMiniApps(localMiniApps: [MiniApp], serverMiniApps: [MiniApp]) -> [MiniApp] {
        var deleteList = [MiniApp]()
        for app in localMiniApps {
            if serverMiniApps.contains(app) == false {
                deleteList.append(app)
            }
        }
        return deleteList
    }
    
    private func mergeAndSave(localMiniApps: [MiniApp], serverMiniApps: [MiniApp]) -> [MiniApp] {
        var map = [String:MiniApp]();
        localMiniApps.forEach { minApp in
            map[minApp.appId] = minApp
        }
        
        var saveList = [MiniApp]()
        var mergedMiniApps = [MiniApp]()
        
        serverMiniApps.forEach { miniApp in
            if let localMiniApp = map[miniApp.appId] {
                if miniApp.version != localMiniApp.version || miniApp.state != localMiniApp.state {
                    localMiniApp.version = miniApp.version
                    localMiniApp.state = miniApp.state
                    saveList.append(localMiniApp)
                }
                
                mergedMiniApps.append(localMiniApp)
            } else { // 新增App
                saveList.append(miniApp)
                mergedMiniApps.append(miniApp)
            }
        }
        save(miniApps: saveList)
        return mergedMiniApps
    }
    
}


extension MiniAppManager {
    
    fileprivate func delete(miniApps: [MiniApp]) {
        
    }
    
    fileprivate func save(miniApps: [MiniApp]) {
        
    }
}
