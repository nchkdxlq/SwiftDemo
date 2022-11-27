//
//  ZStackDemo.swift
//  SwiftUIDemo
//
//  Created by Knox on 2022/11/26.
//  Copyright © 2022 luoquan. All rights reserved.
//

import SwiftUI

struct ZStackDemo: View {
    
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
    
    var body: some View {
        ZStack() {
            ForEach(0..<colors.count) {
                Rectangle()
                    .fill(colors[$0])
                    .frame(width: 100, height: 100)
                    .offset(CGSize(width: $0*20, height: $0*20))
            }
        }
    }
}

struct ZStackDemo_Previews: PreviewProvider {
    static var previews: some View {
        ZStackDemo()
    }
}
