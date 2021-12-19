//
//  Observer.swift
//  DesignPatterns
//
//  Created by Knox on 2021/12/19.
//  Copyright © 2021 luoquan. All rights reserved.
//

import Foundation

/*
 观察者模式（Observer Design Pattern）也被称为发布订阅模式（Publish-Subscribe Design Pattern）.
 
 
 在对象之间定义一个一对多的依赖，当一个对象状态改变的时候，所有依赖的对象都会自动收到通知。
 一般情况下，被依赖的对象叫作被观察者（Observable），依赖的对象叫作观察者（Observer）。
 
 根据应用场景的不同，观察者模式会对应不同的代码实现方式：
 
 观察者模式的应用场景非常广泛，小到代码层面的解耦，大到架构层面的系统解耦，
 再或者一些产品的设计思路，都有这种模式的影子，比如，邮件订阅、RSS Feeds，本质上都是观察者模式。
 
 不同的应用场景和需求下，这个模式也有截然不同的实现方式，有同步阻塞的实现方式，也有异步非阻塞的实现方式；
 有进程内的实现方式，也有跨进程的实现方式。
 
 
 设计模式要干的事情就是解耦。
 1. 创建型模式是将创建和使用代码解耦，
 2. 结构型模式是将不同功能代码解耦，
 3. 行为型模式是将不同的行为代码解耦，具体到观察者模式，它是将观察者和被观察者代码解耦。
 
 */




// 最经典的观察者模式实现

protocol Message {
    var data: String { get }
}

// 被观察者
protocol Subject {
    associatedtype O = Observer
    associatedtype M = Message
    
    func register(observer: O)
    
    func remove(observer: O)
    
    func notify(observer message: M)
}

// 观察者
protocol Observer: Equatable {
    func update(_ message: Message)
}

// 协议扩展，提供协议的默认实现
extension Observer {
    func update(_ message: Message) { }
}

// 通知消息的内容
class LoginMessage: Message {
    let data: String
    init(data: String) {
        self.data = data
    }
}

// MARK: - 被观察者

class ConcreteSubject<O: Observer, M: Message>: Subject {
    
    // 保存所有的Observer
    private var obsList = [O]()
    
    func register(observer: O) {
        obsList.append(observer)
    }
    
    func remove(observer: O) {
        guard let index = obsList.firstIndex(where: { observer == $0 }) else {
            return
        }
        obsList.remove(at: index)
    }
    
    // 通知
    func notify(observer message: Message) {
        obsList.forEach { $0.update(message) }
    }
}

// MARK: - 观察者

class ConcreteObserverOne: Observer {
    static func == (lhs: ConcreteObserverOne, rhs: ConcreteObserverOne) -> Bool {
        return lhs === rhs
    }
    
    
    func update(_ message: Message) {
        print("\(message.data)")
    }
}


class ConcreteObserverTwo: Observer {
    static func == (lhs: ConcreteObserverTwo, rhs: ConcreteObserverTwo) -> Bool {
        return lhs === rhs
    }
    
    
    func update(_ message: Message) {
        print("\(message.data)")
    }
}


class ConcreteObserverThree: Observer {
    static func == (lhs: ConcreteObserverThree, rhs: ConcreteObserverThree) -> Bool {
        return lhs === rhs
    }
    
    func update(_ message: Message) {
        print("\(message.data)")
    }
}


/*
 
 对应到iOS开发中
 
 ### Notification
 
 NotificationCenter 是 Subject(被观察者)
 NotificationCenter.default.addObserver 方法中的Object为观察者, selector为通知方法
 Notification 通知的内容
 
 
 ### KVO
 
 observeValue(forKeyPath:of:change:context:) 为 Observer的通知的方法
 
 */
