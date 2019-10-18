//
//  Map.swift
//  RxSwiftDemo
//
//  Created by Knox on 2019/10/13.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay


enum TestError : Error {
    case httpError
}

class MapTest {
    
    let disposeBag = DisposeBag()
    
    func entry() {
//        map_test()
//        flatMap_test()
//        flatMapLatest_test()
        
        testFlatMap()
    }
    
    // https://beeth0ven.github.io/RxSwift-Chinese-Documentation/content/decision_tree/map.html
    // 通过一个函数将 Observable的每个元素转换一遍
    func map_test() {
        print("------ map ------")
        Observable.of(1, 2, 3)
            .map { $0 * 10}
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    
    // https://beeth0ven.github.io/RxSwift-Chinese-Documentation/content/decision_tree/flatMap.html
    // 通过一个函数，将Observable中的每一个元素转换为一个新的Observable(一个元素对应一个Observable, 新的Observable可以有很多个元素)
    // 然后再所有新产生的Observable的所有元素合并起来再发送
    func flatMap_test() {
        print("------ flatMap ------")
        Observable.of(1, 2, 3)
            .flatMap { (num) -> Observable<String> in
                Observable.of("\(num) & \(num)")
        }.subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
    }
    
    // https://beeth0ven.github.io/RxSwift-Chinese-Documentation/content/decision_tree/flatMapLatest.html
    //  操作符将源 Observable 的每一个元素应用一个转换方法，将他们转换成 Observables。
    // 一旦转换出一个新的 Observable，就只发出它的元素，旧的 Observables 的元素将被忽略掉。
    func flatMapLatest_test() {
        print("------ flatMap ------")
        let first = BehaviorSubject(value: "👦🏻")
        let second = BehaviorSubject(value: "🅰️")

        let replay = BehaviorRelay(value: first)
        replay
            .flatMapLatest { $0 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)

        first.onNext("🐱")
        replay.accept(second)
        second.onNext("🅱️")
        first.onNext("🐶") // 不打印
    }
    
    
    func testFlatMap() {
        let account = "111"
    
        loadServerConfig().flatMap { [unowned self] () -> Observable<String> in
            print("queryLocalInfo")
            return self.queryLocalInfo(account: account)
        }.flatMap { [unowned self] (token) -> Observable<Void> in
            print("login")
            return self.login(account: account, password: "", dToken: token)
        }.subscribe {
            print($0)
        }.disposed(by: disposeBag)
    }
    
    
    func login(account: String, password: String, dToken: String) -> Observable<Void> {
        
        return Observable.create { observer -> Disposable in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                observer.onNext(())
                observer.onError(TestError.httpError)
            }
            
            return Disposables.create()
        }
    }
    
    func queryLocalInfo(account: String) -> Observable<String> {
        
        return Observable.create { observer -> Disposable in
            
            observer.onNext("123456")
            
            return Disposables.create()
        }
        
    }
    
    func loadServerConfig() -> Observable<Void> {
        return Observable.create { observer -> Disposable in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                observer.onNext(())
            }
            return Disposables.create()
        }
    }
    
}
