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
    let downloadURL: String
    let md5: String
    
    init(version: String, downloadURL: String, md5: String) {
        self.version = version
        self.downloadURL = downloadURL
        self.md5 = md5
    }
}

enum MiniAppState {
    case open, close
}

class MiniApp: NSObject {
    let appId: String
    var version: String
    var state = MiniAppState.open
    
    var packageVersion = ""
    var homePath: String?
    
    var donwLoadURL: String?
    var pkgFileMD5 = ""
    
    var diffPackage = [MiniAppDiffPackage]()
    
    init(appId: String, version: String) {
        self.appId = appId
        self.version = version
        super.init()
    }
}
