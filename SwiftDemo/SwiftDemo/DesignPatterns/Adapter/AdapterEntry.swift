//
//  AdapterEntry.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/7/27.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import Foundation


func adapterEntry() {
    
    let mobile = Mobile()
    mobile.charging(voltage: VoltageAdapter())
    
    let v220 = Voltage220()
    let adpter2 = VoltageAdpter2(vol: v220)
    mobile.charging(voltage: adpter2)
    
}


