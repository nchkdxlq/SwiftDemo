//
//  CalculatorView.swift
//  SwiftDemo
//
//  Created by Knox on 2022/5/27.
//  Copyright © 2022 luoquan. All rights reserved.
//

import SwiftUI

struct CalculatorView: View {
    var body: some View {
        return Text("+")
            .font(.system(size: 38))
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            .border(.red, width: 4)
            .background(Color.orange)
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
