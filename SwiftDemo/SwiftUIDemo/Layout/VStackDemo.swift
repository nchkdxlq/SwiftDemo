//
//  VStackDemo.swift
//  SwiftUIDemo
//
//  Created by Knox on 2022/11/26.
//  Copyright © 2022 luoquan. All rights reserved.
//

import SwiftUI

struct VStackDemo: View {
    var body: some View {
        // 子项在垂直方向布局
        VStack(
            alignment: .leading, //子项在水平方向的布局
            spacing: 10 // 垂直方向的间距
        ) {
            ForEach(
                0...10,
                id: \.self
            ) { id in
                Text("Item \(id)")
                    .background(Color.blue)
            }
        }
    }
}

struct VStackDemo_Previews: PreviewProvider {
    static var previews: some View {
        VStackDemo()
    }
}
