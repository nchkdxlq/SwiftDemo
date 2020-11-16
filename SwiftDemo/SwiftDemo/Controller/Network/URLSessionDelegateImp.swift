//
//  URLSessionDelegateImp.swift
//  SwiftDemo
//
//  Created by Knox on 2020/11/12.
//  Copyright © 2020 luoquan. All rights reserved.
//

import Foundation
import UIKit

class URLSessionDelegateImp: NSObject {
    
    
}


extension URLSessionDelegateImp: URLSessionDelegate {
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        print("URLSessionDelegate didBecomeInvalidWithError")
    }
    
    
    /*
        当访问https网站是，需要进行https握手，这时就会调用这个方法，是否信任所访问的网址。
     */
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("URLSessionDelegate session didReceive challenge")
        completionHandler(.performDefaultHandling, nil)
    }
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        print("URLSessionDelegate forBackgroundURLSession")
    }
}




