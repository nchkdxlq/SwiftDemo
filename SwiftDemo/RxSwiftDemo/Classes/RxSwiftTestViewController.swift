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
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        publishSubject_test()
//        replaySubject_test()
        behaviorSubject_test()
        
//        observable_just()
//        observable_of()
//        observable_empty()
//        observable_range()
//        observable_repeatElement()
//        observable_timer()
    }
    
    func button_test() {
        let btn = UIButton(frame: CGRect(x: 100, y: 300, width: 100, height: 50))
        btn.setTitle("Button", for: .normal)
        btn.backgroundColor = UIColor.blue
        view.addSubview(btn)
        
        btn.rx.tap.subscribe(onNext: {
            print("button Tapped")
        }).disposed(by: disposeBag)
    }
    
    
    
    // MARK: - Subject
    
    // 当有观察者订阅 PublishSubject 时，PublishSubject 会发射订阅之后的数据给这个观察者。
    func publishSubject_test() {
        let publishSubject = PublishSubject<String>()
        
        publishSubject.subscribe { e in
            print("Subscription: 1, event: \(e)")
        }.disposed(by: disposeBag)
        
        publishSubject.on(.next("a"))
        publishSubject.on(.next("b"))
        
        publishSubject.subscribe { e in // 我们可以在这里看到，这个订阅只收到了两个数据，只有 "c" 和 "d"
            print("Subscription: 2, event: \(e)")
        }.disposed(by: disposeBag)
        
        publishSubject.on(.next("c"))
        publishSubject.on(.next("d"))
    }
    
    // 和 PushblishSubject 不同，不论观察者什么时候订阅， ReplaySubject 都会发射完整的数据给观察者。
    func replaySubject_test() {
        let replaySubject = ReplaySubject<String>.create(bufferSize: 2)
        
        replaySubject.subscribe { e in
            print("Subscription: 1, event: \(e)")
        }.disposed(by: disposeBag)
        
        replaySubject.on(.next("a"))
        replaySubject.on(.next("b"))
        
        replaySubject.subscribe { e in
            print("Subscription: 2, event: \(e)")
        }.disposed(by: disposeBag)
        
        replaySubject.on(.next("c"))
        replaySubject.on(.next("d"))
    }
    
    // 当一个观察者订阅一个 BehaviorSubject ，它会发送原序列最近的那个值（如果原序列还有没发射值那就用一个默认值代替），之后继续发射原序列的值。
    func behaviorSubject_test() {
        let bs = BehaviorSubject(value: "AA")
        bs.subscribe { event in
            print("subject 1 : ", event)
        }.disposed(by: disposeBag)
        
        bs.on(.next("a"))
        bs.on(.next("b"))
        
        bs.subscribe { event in
            print("subject 2 : ", event)
        }.disposed(by: disposeBag)
        
        bs.on(.next("c"))
        bs.on(.next("d"))
        bs.on(.completed)
    }
    
    
    // MARK: - Observable
    
    func observable_just() {
        let one = 1
        let observable = Observable<Int>.just(one)
        observable.subscribe { (e) in
            print(e)
        }.disposed(by: disposeBag)
    }
    
    func observable_of() {
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
    

    func observable_empty() {
        // 创建一个空的序列，只发射一个 .completed：
        let obs3 = Observable<Int>.empty()
        obs3.subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
    }
    
    func observable_range() {
        print("------ range ------")
        let obs = Observable.range(start: 1, count: 10)
        obs.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
    }
    
    func observable_repeatElement() {
        print("------ repeatElement ------")
        let obs = Observable.repeatElement(1)
        obs.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
    }
    
    func observable_timer() {
        print("------ timer ------")
        let obs = Observable<Int>.timer(.seconds(1), period: .seconds(2), scheduler: MainScheduler.instance)
        obs.subscribe { event in
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
