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

class ObservableTest {
    
    private let disposeBag = DisposeBag()
    
    func entry() {
        
        sendTextMessage()
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
    
    
    
    func sendTextMessage() {
        let msg = Message()
        msg.mid = NSUUID().uuidString
        msg.umid = 100
        msg.type = .text
        msg.state = .idle
        
        let obs = sendMessage(msg)
        print("before")
        obs.subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
    }
}




class Message {
    
    // 消息转态
    enum MessageState {
        case idle, sending, success, failed
    }
    
    // 消息类型
    enum MessageType {
        case text, image, audio, video, file
    }
    
    var umid: UInt = 0
    var mid: String = ""
    var state: MessageState = .idle
    var type: MessageType = .text
}



/*
 实现如下需求
 1. 发送消息过程，
 a) 消息发送中转圈
 b) 发送成功隐藏转圈
 c) 发送失败隐藏转圈并显示感叹号
 
 
 疑问？
 
 1. Observable什么时候释放
 
 
 */


/*
 
 创建一个`Observable`, 把需要做的事情放在闭包里面, 比如网络请求、读取文件等等
 
 */
func sendMessage(_ msg: Message) -> Observable<Message.MessageState> {
    return Observable<Message.MessageState>.create { (observer) -> Disposable in
        msg.state = .sending
        observer.on(.next(.sending))
        // 1s后发送成功
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            msg.state = .success
            observer.on(.next(.success))
        }
        return Disposables.create()
    }
}
