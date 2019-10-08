//
//  RxSwiftTestViewController.swift
//  RxSwiftDemo
//
//  Created by Knox on 2019/9/29.
//  Copyright © 2019 luoquan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxSwiftTestViewController: BaseViewController {

    let disposeBag = DisposeBag()
    let transforming = Transforming()
    let subject = Subject()
    let observable = ObservableTest()
    let comnination = Combination()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        subject.entry()
//        observable.entry()
//        transforming.entry()
        comnination.entry()
        
        
//        button_test()
    }
    
    func button_test() {
        let btn = UIButton(frame: CGRect(x: 100, y: 300, width: 100, height: 50))
        btn.setTitle("Button", for: .normal)
        btn.backgroundColor = UIColor.blue
        view.addSubview(btn)
        
//        btn.rx.tap.subscribe(onNext: {
//            print("button Tapped")
//        }).disposed(by: disposeBag)
        
//        btn.rx.tap.map { event -> Int in
//            return 1
//            }.scan(0) { (sum, value) -> Int in
//                return sum + value
//            }.subscribe(onNext: { (value) in
//                print(value)
//            }).disposed(by: disposeBag)
//
        btn.rx.tap
            .map { return 1 }
            .scan(0) { acc, x in return acc + x }
            .subscribe { event in
                print(event)
            }.disposed(by: disposeBag)
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
