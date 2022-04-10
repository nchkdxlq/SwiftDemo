//
//  MiniApp.swift
//  SwiftDemo
//
//  Created by Knox on 2022/4/5.
//  Copyright © 2022 luoquan. All rights reserved.
//

import Foundation

class MiniAppDiffPackage {
    let version: String
    let fid: String
    let md5: String
    
    var isDiffPackage: Bool {
        return version.count > 0
    }
    
    init(version: String, fid: String, md5: String) {
        self.version = version
        self.fid = fid
        self.md5 = md5
    }
}

enum MiniAppState {
    case open, close
}

class MiniApp: NSObject {
    
    let appId: String
    let xxAppId: String
    var version: String
    var host: String
    var path: String
    var name: String
    var isIntranet = false
    var state: Int
    var curPackageInfo: MiniAppDiffPackage
    var diffPackageInfos = [MiniAppDiffPackage]()
    
    var packageVersion = ""
    var homePath: String?
    
    var isActive: Bool {
        return state == 1
    }
    
    init(_ info: [String:Any]) {
        appId = info["id"] as? String ?? ""
        xxAppId = info["xxAppId"] as? String ?? ""
        version = info["version"] as? String ?? ""
        host = info["host"] as? String ?? ""
        path = info["path"] as? String ?? ""
        name = info["name"] as? String ?? ""
        isIntranet = info["isIntranet"] as? Bool ?? false
        state = info["info"] as? Int ?? 0
        
        let fid = info["pkgFid"] as? String ?? ""
        let md5 = info["md5"] as? String ?? ""
        curPackageInfo = MiniAppDiffPackage(version: "", fid: fid, md5: md5)
        
        if let diffPkgInfos = info[""] as? [[String:Any]] {
            for info in diffPkgInfos {
                if let fid = info["pkgFid"] as? String,
                   let md5 = info["md5"] as? String,
                   let version = info["version"] as? String {
                   let pkg = MiniAppDiffPackage(version: version, fid: fid, md5: md5)
                    diffPackageInfos.append(pkg)
                }
            }
        }
        
        super.init()
    }
    
}
