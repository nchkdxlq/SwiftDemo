//
//  Combination.swift
//  RxSwiftDemo
//
//  Created by Knox on 2019/9/30.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation
import RxSwift

struct Combination {
    
    private let disposeBag = DisposeBag()
    
    
    func entry() {
     
        startWith_test()
        
        merge_test()
        
        zip_test()
        
        combineLatest_test()
    }
    
    
    private func startWith_test() {
        print("------- startWith -------")
        // 发送序列数据之前，先发送指定的序列
        Observable.of(1, 2, 3).startWith(-1, 0).subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
        
        // -1, 0, 1, 2, 3, 4, .completed
    }
    
    
    private func merge_test() {
        print("------- merge -------")
        // 将多个Observable组合成单个Observable,并且按照时间顺序发射对应事件
        
        let sub1 = PublishSubject<String>()
        let sub2 = PublishSubject<String>()
        
        Observable.of(sub1, sub2).merge().subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
        
        sub1.onNext("A")
        sub1.onNext("B")
        sub2.onNext("1")
        sub2.onNext("2")
        // next(A) next(B) next(1) next(2)
    }
    
    
    private func zip_test() {
        print("------- zip -------")
        /*
         将多个`Observable`组合成单个`Observable`,最多支持8个`Observable`。当每个Observable有时间到达后，才会触发zip后生产的Observable发送事件。
         比如，sub1先发送 "A"、"B", 此时zipObs是不会发送事件的。只有等到sub2发送"1", 此时才会发送事件，打印的结果为 "A & 1". 此时只消费了sub1的一个事件，
         只有当sub2再次发送事件时，zipObs才会发送事件。总结zipObs发送的事件个数等于各个`Observable`发送最少的次数.
         */
        let sub1 = PublishSubject<String>()
        let sub2 = PublishSubject<String>()
        
        let zipObs = Observable.zip(sub1, sub2) { (element1, element2) -> String in
            return element1 + " & " + element2
        }
        
        zipObs.subscribe(onNext: { value in
            print(value)
        }).disposed(by: disposeBag)
        
        sub1.onNext("A")
        sub1.onNext("B")
        sub2.onNext("1")
        sub2.onNext("2")
    }
    
    
    private func combineLatest_test() {
        print("------- combineLatest -------")
        
        /*
         combineLatest把多个`Observable`组合为一个`Observale`, 被combine的`Observable`只会保留最后一个事件，
         当只有部分`Observable`发送事件时，不会触发`combineObs`发送事件，只有当每个`Observable`都发送过事件时，才会触发`combineObs`发送事件，
         并且把每个`Observable`的最后一个事件的的值传递给`combineObs`，`combineObs`才会触发事件。
         */
        
        let sub1 = PublishSubject<String>()
        let sub2 = PublishSubject<String>()
        
        let comObs = Observable.combineLatest(sub1, sub2) { (string1, string2) in
            return string1 + "-" + string2
        }
        
        comObs.subscribe(onNext: { value in
            print(value)
        }).disposed(by: disposeBag)
        
        sub1.onNext("A")
        sub2.onNext("1")
        sub1.onNext("B")
        sub2.onNext("2")
        
        // A-1
        // B-1
        // B-2
    }
    
}
