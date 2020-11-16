//
//  SessionDownloadDelegateImp.swift
//  SwiftDemo
//
//  Created by Knox on 2020/11/12.
//  Copyright © 2020 luoquan. All rights reserved.
//

import Foundation



extension URLSessionDelegateImp: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("URLSessionDownloadDelegate didFinishDownloadingTo location = \(location)")
    }
    
    
}
