//
//  Share.swift
//  RxSwiftDemo
//
//  Created by Knox on 2019/10/11.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation
import RxSwift


struct ShareTest {
    
    let disposeBag = DisposeBag()
    
    func entry() {
        
        share_reply_test()
    }
    
    /*
     share(replay:scope:) 会返回一个新的序列, 它监听上游的事件序列, 然后再把事件发送给自己的订阅者。
     这样解决了多个订阅者的情况下, map会被执行多次的问题
     */
    private func share_reply_test() {
        // "🐂", "🐎", "🐑"
        
        let seq = PublishSubject<String>()
        let obs = seq.map { value -> String in
            print("Map", value)
            return value + value
        }
//        .share()
//        .share(replay: 1)
        .share(replay: 1, scope: .whileConnected)
        
        // share() 等价于 share(replay: 0, scope: .whileConnected)
        // share(replay: 1) 等价于 share(replay: 1, scope: .whileConnected)
        
        obs.subscribe(onNext: {
            print("--- 1 ---", $0)
            }).disposed(by: disposeBag)
        
        
        obs.subscribe(onNext: {
            print("--- 2 ---", $0)
            }).disposed(by: disposeBag)
        
        obs.subscribe(onNext: {
            print("--- 3 ---", $0)
            }).disposed(by: disposeBag)
        
        seq.onNext("🐂")
        seq.onNext("🐱")
        seq.onNext("🐑")
    }
    
}
