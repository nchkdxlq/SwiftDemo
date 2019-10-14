//
//  Take&Skip.swift
//  RxSwiftDemo
//
//  Created by Knox on 2019/10/13.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation
import RxSwift


struct Take_Skip {
    
    let disposeBag = DisposeBag()
    
    
    // 总结： take系列操作符是发送头几个元素，遇到不满足条件停止发送; skip系列操作符忽略前面的n个元素，直到满足条件才发送元素
    func entry() {
        take_test()
        takeLast_test()
        takeWhile_test()
        
        skip_test()
        skipUntil_test()
        skipWhile_test()
    }
    
    func take_test() {
        print("------ take ------")
        // 只发出前面的n个元素
        Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
            .take(3)
            .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
    }
    
    func takeLast_test() {
        print("------ takeLast ------")
        // 只发出后面的n个元素
        Observable.of("🐱", "🐰", "🐶", "🐸", "🐷", "🐵")
            .takeLast(3)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    // takeUntil操作符将镜像源 Observable，它同时观测第二个 Observable。
    // 一旦第二个 Observable 发出一个元素或者产生一个终止事件，那个镜像的 Observable 将立即终止
    func takeUntil_test() {
        print("------ takeUntil ------")
        
        // tableUntil镜像srcSeq, 同时监听refSeq, 只要当refSeq发送信号, srcSeq就会立即发送complte信号, 后不在发送信号
        let srcSeq = PublishSubject<String>()
        let refSeq = PublishSubject<String>()
        
        srcSeq.takeUntil(refSeq)
            .subscribe { print($0) }
            .disposed(by: disposeBag)
        
        srcSeq.onNext("source 🐱")
        srcSeq.onNext("source 🐰")
        srcSeq.onNext("source 🐶")
        
        refSeq.onNext("ref 🔴") // refSeq发送一个信号
        
        // 后序srcSeq发送的信号不会被发给订阅者
        srcSeq.onNext("source 🐸")
        srcSeq.onNext("source 🐷")
        srcSeq.onNext("source 🐵")
    }
    
    
    // 镜像一个序列，直到某个元素的判定为 false, 序列将立即终止
    func takeWhile_test() {
        print("------ takeWhile ------")
        Observable.of(1, 2, 3, 4, 3, 2, 1)
            .takeWhile { $0 < 4}
            .subscribe { print($0) }
            .disposed(by: disposeBag)
    }
    
    
    // skip操作符忽略头 n 个元素，只关注后面的元素。
    func skip_test() {
        print("------ skip ------")
        
        Observable.of(1, 2, 3, 4)
            .skip(2).subscribe { print($0) }
            .disposed(by: disposeBag)
    }
    
    // skipUntil 操作符可以让你忽略源 Observable 中头几个元素，直到另一个 Observable 发出一个元素后，它才镜像源 Observable。
    func skipUntil_test() {
        print("------ skipUntil ------")
        
        let srcSeq = PublishSubject<Int>()
        let refSeq = PublishSubject<Int>()
        
        srcSeq.skipUntil(refSeq)
            .subscribe { print($0) }
            .disposed(by: disposeBag)
        
        srcSeq.onNext(1)
        srcSeq.onNext(2)
        
        refSeq.onNext(1)
        
        srcSeq.onNext(3)
        srcSeq.onNext(4)
    }
    
    // skipWhile 操作符可以让你忽略源 Observable 中头几个元素，直到元素的判定为否后，它才镜像源 Observable。
    func skipWhile_test() {
        print("------ skipWhile ------")
        
        Observable.of(1, 2, 3, 4, 5)
            .skipWhile { $0 < 3 }
            .subscribe { print($0) }
            .disposed(by: disposeBag)
        
    }
    
}
