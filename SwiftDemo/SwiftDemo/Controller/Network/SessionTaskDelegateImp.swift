//
//  SessionTaskDelegateImp.swift
//  SwiftDemo
//
//  Created by Knox on 2020/11/12.
//  Copyright © 2020 luoquan. All rights reserved.
//

import Foundation


extension URLSessionDelegateImp: URLSessionTaskDelegate {
    
    @available(iOS 11.0, *)
    func urlSession(_ session: URLSession, task: URLSessionTask, willBeginDelayedRequest
                        request: URLRequest,
                    completionHandler: @escaping (URLSession.DelayedRequestDisposition, URLRequest?) -> Void) {
        print("URLSessionTaskDelegate willBeginDelayedRequest")
        completionHandler(.continueLoading, request);
    }
    
    
    func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) {
        print("URLSessionTaskDelegate taskIsWaitingForConnectivity")
    }
    
    // 重定向时被调用
    func urlSession(_ session: URLSession, task: URLSessionTask,
                    willPerformHTTPRedirection response: HTTPURLResponse,
                    newRequest request: URLRequest,
                    completionHandler: @escaping (URLRequest?) -> Void) {
        print("URLSessionTaskDelegate willPerformHTTPRedirection")
    }
    
    // 接收到服务器的信任挑战是调用
    func urlSession(_ session: URLSession, task: URLSessionTask,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("URLSessionTaskDelegate didReceive challenge")
        completionHandler(.performDefaultHandling, nil);
    }
    
    
    func urlSession(_ session: URLSession, task: URLSessionTask,
                    needNewBodyStream completionHandler: @escaping (InputStream?) -> Void) {
        print("URLSessionTaskDelegate needNewBodyStream")
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask,
                    didSendBodyData bytesSent: Int64,
                    totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        print("URLSessionTaskDelegate didSendBodyData")
    }
    
    /*
     [?]
     URLSessionTaskMetrics 是什么东西?

     */
    func urlSession(_ session: URLSession, task: URLSessionTask,
                    didFinishCollecting metrics: URLSessionTaskMetrics) {
        print("URLSessionTaskDelegate didFinishCollecting")
    }
    
    // 请求接收数据完成调用或者请求失败调用
    /*
     URLSessionDataTask: 接收数据完毕调用
     
     */
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("URLSessionTaskDelegate didCompleteWithError", error ?? "success")
        if task is URLSessionDataTask {
            print("URLSessionTaskDelegate URLSessionDataTask 接收数据完毕")
        }
    }
}
