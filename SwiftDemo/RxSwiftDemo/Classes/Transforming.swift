//
//  Transforming.swift
//  RxSwiftDemo
//
//  Created by Knox on 2019/9/29.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


struct Transforming {
    
    private let disposeBag = DisposeBag()
    
    func entry() {
        
//        map_test()
//        flatMap_test()
//        scan_test()
//        reduce_test()
//        buffer_test()
        window_test()
    }

    private func map_test() {
        print("------- map -------")
        
        let seq = Observable.of(1, 2, 3)
        
        seq.map { $0 * 2 }
            .subscribe { event in
                print(event)
            }.disposed(by: disposeBag)
    }
    
    
    private func flatMap_test() {
        print("------- map -------")
        
        let seqInt = Observable.of(1, 2)
        let seqString = Observable.of("A", "B", "C", "D", "E", "F", "--")
        
        seqInt.flatMap { (event) -> Observable<String> in
            return seqString
        }.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
    }
    
    // 应用一个 accumulator (累加) 的方法遍历一个序列，然后返回累加的结果。
    // 此外我们还需要一个初始的累加值。实时上这个操作就类似于 Swift 中的 reduce 。
    private func scan_test() {
        print("------- scan -------")
        
        let seqInt = Observable.of(0, 1, 2, 3, 4, 5)
        seqInt.scan(0) { (sum, element) -> Int in
            print("element : ", element)
            return sum + element
        }.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
    }
    
    // 和 scan 非常相似，唯一的不同是， reduce 会在序列结束时才发射最终的累加值。就是说，最终只`发射一个最终累加值`。
    func reduce_test() {
        print("------- reduce -------")
        
        let seqInt = Observable.of(0, 1, 2, 3, 4, 5)
        seqInt.reduce(0) { (sum, element) -> Int in
            print("element : ", element)
            return sum + element
        }.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
        
    }
    
    func buffer_test() {
        print("------- buffer -------")
        
        let seqInt = Observable.of(0, 1, 2, 3, 4, 5)
        
        seqInt
            .buffer(timeSpan: .seconds(5), count: 2, scheduler: MainScheduler.instance)
            .subscribe { event in
                print(event)
            }.disposed(by: disposeBag)
        
    }
    
    // window 和 buffer 非常类似。唯一的不同就是 window 发射的是序列， buffer 发射一系列值。
    func window_test() {
        print("------- window -------")
        
        let seqInt = Observable.of(0, 1, 2, 3, 4, 5)
        seqInt
            .window(timeSpan: .seconds(5), count: 2, scheduler: MainScheduler.instance)
            .subscribe { event in
                print(event)
            }.disposed(by: disposeBag)
    }
}


