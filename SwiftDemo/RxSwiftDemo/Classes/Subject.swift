//
//  Subject.swift
//  RxSwiftDemo
//
//  Created by Knox on 2019/9/30.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation
import RxSwift


struct Subject {
    
    private let disposeBag = DisposeBag()
    
    func entry() {
        
        publishSubject_test()
        behaviorSubject_test()
        replaySubject_test()
    }
    
    // 当有观察者订阅 PublishSubject 时，PublishSubject 会发射订阅之后的数据给这个观察者。
    private func publishSubject_test() {
        let publishSubject = PublishSubject<String>()
        
        publishSubject.subscribe { e in
            print("Subscription: 1, event: \(e)")
        }.disposed(by: disposeBag)
        
        publishSubject.on(.next("a"))
        publishSubject.on(.next("b"))
        
        publishSubject.subscribe { e in // 我们可以在这里看到，这个订阅只收到了两个数据，只有 "c" 和 "d"
            print("Subscription: 2, event: \(e)")
        }.disposed(by: disposeBag)
        
        publishSubject.on(.next("c"))
        publishSubject.on(.next("d"))
    }
    
    // 和 PushblishSubject 不同，不论观察者什么时候订阅， ReplaySubject 都会发射完整的数据给观察者。
    private func replaySubject_test() {
        let replaySubject = ReplaySubject<String>.create(bufferSize: 2)
        
        replaySubject.subscribe { e in
            print("Subscription: 1, event: \(e)")
        }.disposed(by: disposeBag)
        
        replaySubject.on(.next("a"))
        replaySubject.on(.next("b"))
        
        replaySubject.subscribe { e in
            print("Subscription: 2, event: \(e)")
        }.disposed(by: disposeBag)
        
        replaySubject.on(.next("c"))
        replaySubject.on(.next("d"))
    }
    
    // 当一个观察者订阅一个 BehaviorSubject ，它会发送原序列最近的那个值（如果原序列还有没发射值那就用一个默认值代替），之后继续发射原序列的值。
    private func behaviorSubject_test() {
        let bs = BehaviorSubject(value: "AA")
        bs.subscribe { event in
            print("subject 1 : ", event)
        }.disposed(by: disposeBag)
        
        bs.on(.next("a"))
        bs.on(.next("b"))
        
        bs.subscribe { event in
            print("subject 2 : ", event)
        }.disposed(by: disposeBag)
        
        bs.on(.next("c"))
        bs.on(.next("d"))
        bs.on(.completed)
    }
    
    
}
