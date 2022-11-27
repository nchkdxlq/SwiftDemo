//
//  HStackDemo.swift
//  SwiftUIDemo
//
//  Created by Knox on 2022/11/26.
//  Copyright © 2022 luoquan. All rights reserved.
//

import SwiftUI

struct HStackDemo: View {
    var body: some View {
        HStack(
            alignment: .top,
            spacing: 10
        ) {
            ForEach(
                0...4,
                id: \.self
            ) {
                Text("Item \($0)")
                    .background(Color.orange)
            }
        }
    }
}

struct HStackDemo_Previews: PreviewProvider {
    static var previews: some View {
        HStackDemo()
    }
}
