//
//  WeatherData.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/8/1.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation

class WeatherData : Subject {
    
    private(set) var temperature = 0.0
    private(set) var humidity = 0.0
    private(set) var pressure = 0.0
    
    private var changed = false
    
    var obs: [Observer] = [Observer]()
    
    func registerObserver(_ ob: Observer) {
        obs.append(ob)
    }
    
    
    func removeObserver(_ ob: Observer) {
        
    }
    
    func notifyObservers() {
        if changed == false {
            return
        }
        obs.forEach{ $0.dataDidUpdate($0) }
        changed = false
    }
    
    func setMeasurements(temperature: Double,
                         humidity: Double,
                         presure: Double) {
        self.temperature = temperature
        self.humidity = humidity
        self.pressure = presure
        changed = true
        notifyObservers()
    }
    
}
