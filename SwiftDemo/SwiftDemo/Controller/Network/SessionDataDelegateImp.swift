//
//  SessionDataDelegateImp.swift
//  SwiftDemo
//
//  Created by Knox on 2020/11/12.
//  Copyright © 2020 luoquan. All rights reserved.
//

import Foundation


extension URLSessionDelegateImp: URLSessionDataDelegate {
    
    // 当接收到响应头时被调用
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask,
                    didReceive response: URLResponse,
                    completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        print("URLSessionDataDelegate didReceive response")
        if let httpResponse = response as? HTTPURLResponse {
            print("URLSessionDataDelegate HTTPURLResponse statusCode = \(httpResponse.statusCode)")
        }
        completionHandler(.allow)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didBecome streamTask: URLSessionStreamTask) {
        print("URLSessionDataDelegate didBecome streamTask")
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didBecome downloadTask: URLSessionDownloadTask) {
        print("URLSessionDataDelegate didBecome downloadTask")
    }
    
    /*
     接收到服务器返回的数据时调用
     一个请求可能调用多次该方法，因为返回的数据比较大时，会分片返回
     */
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("URLSessionDataDelegate receive data (data.count = \(data.count))")
    }
    
    /*
     即将缓存请求响应体时调用
     */
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, willCacheResponse proposedResponse: CachedURLResponse, completionHandler: @escaping (CachedURLResponse?) -> Void) {
        print("URLSessionDataDelegate willCacheResponse")
        completionHandler(nil)
    }
}
