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
