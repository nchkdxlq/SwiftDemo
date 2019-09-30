//
//  Filter.swift
//  RxSwiftDemo
//
//  Created by Knox on 2019/9/29.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation
import RxSwift


struct Filter {
    
    private let disposeBag = DisposeBag()
    
    func filter_entry() {
        filter_test()
    }
    
    private func filter_test() {
        print("------ filter ------")
        
        let seqInt = Observable.of(0, 1, 2, 3, 4)
        seqInt.filter { num -> Bool in
            return num % 2 == 0
        }.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
    }
    
}
