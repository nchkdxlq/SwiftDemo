//
//  CalculatorApp.swift
//  SwiftUIDemo
//
//  Created by luoquan on 2022/10/20.
//  Copyright © 2022 luoquan. All rights reserved.
//

import SwiftUI

struct CalculatorButtonPad: View {
    var body: some View {
        
        let pad: [[CalculatorButtonItem]] = [
            [.command(.clear), .command(.flip), .command(.percent), .op(.divide)],
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

struct CalculatorApp: View {
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            Text("0")
                .font(.system(size: 76))
                .minimumScaleFactor(0.5)
                .padding(.trailing, 24)
                .lineLimit(1)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            CalculatorButtonPad()
                .padding(.bottom)
        }
    }
}


struct CalculatorApp_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorApp()
    }
}
