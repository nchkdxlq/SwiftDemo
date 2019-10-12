//
//  Observer.swift
//  RxSwiftDemo
//
//  Created by Knox on 2019/10/9.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation
import RxSwift

struct ObserverTest {
    
    private let disposeBag = DisposeBag()
    
    func entry() {
        
        let observer = AnyObserver<Int> { (event) in
            switch event {
            case .next(let num):
                print("AnyObserver: \(num)")
            case .error(let error):
                print("Error: \(error)")
            default:
                break
            }
        }
        
        Observable.just(1).bind(to: observer).disposed(by: disposeBag)
    }
    
}

/*
 
 在实际开发中，创建`Observer`比较容易, 可以利用`AnyObserver`直接创建; 也可以使用`Binder`创建。创建好Observer后直接订阅`Observable`就可以。
 
 
 那如何创建`Observable`呢？如何与实际的业务结合起来。
 
 
 */
