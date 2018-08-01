//
//  Display.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/8/1.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation


protocol DisplayElement {
    func display()
}


class CurrentConditionsDisplay : Observer & DisplayElement {
    
    let wd: WeatherData
    
    init(_ wd: WeatherData) {
        self.wd = wd
        wd.registerObserver(self)
    }
    
    func dataDidUpdate(_ subject: Any) {
        display()
    }
    
    func display() {
        print("temperature = \(wd.temperature), humidity = \(wd.humidity), pressure = \(wd.pressure)")
    }
}


class StatistisDisplay : Observer & DisplayElement {
    
    let wd: WeatherData
    
    init(_ wd: WeatherData) {
        self.wd = wd
        wd.registerObserver(self)
    }
    
    func dataDidUpdate(_ subject: Any) {
        display()
    }
    
    func display() {
        print("StatistisDisplay")
    }
}


class ThirdPartyDisplay : Observer & DisplayElement {
    
    let wd: WeatherData
    
    init(_ wd: WeatherData) {
        self.wd = wd
        wd.registerObserver(self)
    }
    
    func dataDidUpdate(_ subject: Any) {
        display()
    }
    
    func display() {
        print("ThirdPartyDisplay")
    }
}



