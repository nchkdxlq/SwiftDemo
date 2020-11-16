//
//  SessionStreamDelegateImp.swift
//  SwiftDemo
//
//  Created by Knox on 2020/11/12.
//  Copyright © 2020 luoquan. All rights reserved.
//

import Foundation


extension URLSessionDelegateImp: URLSessionStreamDelegate {
    
    func urlSession(_ session: URLSession, readClosedFor streamTask: URLSessionStreamTask) {
        
    }
    
    func urlSession(_ session: URLSession, writeClosedFor streamTask: URLSessionStreamTask) {
        
    }
    
    func urlSession(_ session: URLSession, betterRouteDiscoveredFor streamTask: URLSessionStreamTask) {
        
    }
    
    func urlSession(_ session: URLSession, streamTask: URLSessionStreamTask,
                    didBecome inputStream: InputStream, outputStream: OutputStream) {
        
    }
}
