//
//  SessionWebSocketDelegateImp.swift
//  SwiftDemo
//
//  Created by Knox on 2020/11/12.
//  Copyright © 2020 luoquan. All rights reserved.
//

import Foundation

extension URLSessionDelegateImp: URLSessionWebSocketDelegate {
    
    @available(iOS 13.0, *)
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask,
                    didOpenWithProtocol protocol: String?) {
        
    }
    
    @available(iOS 13.0, *)
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask,
                    didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        
    }
    
}
