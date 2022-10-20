//
//  CalculatorButtonRow.swift
//  SwiftUIDemo
//
//  Created by luoquan on 2022/10/20.
//  Copyright © 2022 luoquan. All rights reserved.
//

import SwiftUI

struct CalculatorButtonRow: View {
    
    let row: [CalculatorButtonItem]
    
    var body: some View {
        HStack() {
            ForEach(row, id: \.self) { item in
                CalculatorButton(
                    title: item.title,
                    size: item.size,
                    backgroundColorName: item.backgroundColorName)
                {
                    print(item.title)
                }
            }
        }
    }
}

struct CalculatorButtonRow_Previews: PreviewProvider {
    
    
    static var previews: some View {
        let row: [CalculatorButtonItem] = [
            .digit(1), .digit(2), .digit(3), .op(.plus)
        ]
        CalculatorButtonRow(row: row)
    }
}
