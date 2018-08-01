//
//  ObserverEntry.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/8/1.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation

/*
 
 
 观察者模式
 定义：定义了对象之间一对多的依赖，当一个对象状态改变时
 依赖它的对象都会收到通知并自动更新。
 
 角色划分
 1. 抽象被观察者（Observable）
 定义被观察者接口、协议，方便观察者添加和移除监听
 func registerObserver()
 func removeObserver()
 func notifyObservers()
 
 2. 抽象观察者
 定义通知接口、协议 Observer
 func update()
 
 3. 主题，实现 Observable协议
 
 4. 实际的观察者，实现Observer协议
 
 
 */


func ObserverEntry() {
    
    let wd = WeatherData()
    
    _ = CurrentConditionsDisplay(wd)
    _ = StatistisDisplay(wd)
    _ = ThirdPartyDisplay(wd)
    
    wd.setMeasurements(temperature: 67, humidity: 89, presure: 100)
}
