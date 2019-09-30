//
//  Extension.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 16/9/25.
//  Copyright © 2016年 nchkdxlq. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Array

extension Array {
    
    subscript(input: [Int]) -> ArraySlice<Element> {
        get {
            var result = ArraySlice<Element>()
            for i in input {
                assert(i < self.count, "Index out of range")
                result.append(self[i])
            }
            return result
        }
        
        set {
        
//            for i in 0..<input.count {
//                let index = input[i]
//                assert(index < self.count, "Index out of range")
//                self[index] = newValue[i]
//            }
            
            for (index, i) in input.enumerated() {
                assert(i < self.count, "Index out of range")
                self[i] = newValue[index]
            }
        }
    }
    
    
}


extension CGPoint {
    
    func distence(from other: CGPoint) -> CGFloat {
        let deltaX = self.x - other.x
        let deltaY = self.y - other.y
        return sqrt(deltaX * deltaX + deltaY * deltaY)
    }
    
}













