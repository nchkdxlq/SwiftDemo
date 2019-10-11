//
//  Observable.swift
//  RxSwiftDemo
//
//  Created by Knox on 2019/9/30.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct ObservableTest {
    
    private let disposeBag = DisposeBag()
    
    func entry() {
        
        observable_just()
        observable_of()
        
    }
    
    private func observable_just() {
        let one = 1
        let observable = Observable<Int>.just(one)
        observable.subscribe { (e) in
            print(e)
        }.disposed(by: disposeBag)
        
        // 等价上面的
        let obs = Observable<Int>.create { (observer) -> Disposable in
            observer.on(.next(one))
            observer.onCompleted()
            return Disposables.create()
        }
        obs.subscribe{ event in
            print("create", event)
        }.disposed(by: disposeBag)
    }
    
    private func observable_of() {
        let obs1 = Observable.of(1, 2, 3)
        obs1.subscribe(onNext: { (e) in
            print(e)
        }, onCompleted: {
            print("completed")
        }).disposed(by: disposeBag)
        
        
        let obs2 = Observable.of([1, 2, 3])
        obs2.subscribe(onNext: { (e) in
            print(e)
        }, onCompleted: {
            print("completed")
        }).disposed(by: disposeBag)
    }
    

    private func observable_empty() {
        // 创建一个空的序列，只发射一个 .completed：
        let obs3 = Observable<Int>.empty()
        obs3.subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
    }
    
    private func observable_range() {
        print("------ range ------")
        let obs = Observable.range(start: 1, count: 10)
        obs.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
    }
    
    private func observable_repeatElement() {
        print("------ repeatElement ------")
        let obs = Observable.repeatElement(1)
        obs.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
    }
    
    private func observable_timer() {
        print("------ timer ------")
        let obs = Observable<Int>.timer(.seconds(1), period: .seconds(2), scheduler: MainScheduler.instance)
        obs.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
    }
    
    
    
}
