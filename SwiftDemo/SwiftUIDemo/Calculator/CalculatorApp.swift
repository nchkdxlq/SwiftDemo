//
//  CalculatorApp.swift
//  SwiftUIDemo
//
//  Created by luoquan on 2022/10/20.
//  Copyright © 2022 luoquan. All rights reserved.
//

import SwiftUI

struct CalculatorApp: View {
    var body: some View {
        
        let pad: [[CalculatorButtonItem]] = [
            [.command(.clear), .command(.flip), .command(.percent), .op(.divice)],
            [.digit(7), .digit(8), .digit(9), .op(.multiply)],
            [.digit(4), .digit(5), .digit(6), .op(.minus)],
            [.digit(1), .digit(2), .digit(3), .op(.plus)],
            [.digit(0), .dot, .op(.equal)]
        ]
        
        VStack(spacing: 8) {
            ForEach(pad, id: \.self) { row in
                CalculatorButtonRow(row: row)
            }
        }
    }
}



struct CalculatorApp_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorApp()
    }
}
