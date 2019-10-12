//
//  Bind.swift
//  RxSwiftDemo
//
//  Created by Knox on 2019/10/9.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

struct BindTest {
    
    private let disposeBag = DisposeBag()
    
    func entry() {
        
        
    }
    
    private func bind_test() {
        let label = UILabel()
        
        let obs = Observable.of(1, 2, 3).map { num -> String? in "\(num)" }
        obs.subscribe(label.rx.myText).disposed(by: disposeBag)
        
    }
}



extension Reactive where Base : UIView {
    var isMyHidden: Binder<Bool> {
        return Binder(self.base) { (view, hidden) in
            view.isHidden = hidden
        }
    }
}


extension Reactive where Base : UIControl {
    var isMyEnable: Binder<Bool> {
        return Binder(self.base) { (control, enable) in
            control.isEnabled = enable
        }
    }
}


extension Reactive where Base : UILabel {
    var myText: Binder<String?> {
        return Binder(self.base) { (label, text) in
            label.text = text
        }
    }
}
