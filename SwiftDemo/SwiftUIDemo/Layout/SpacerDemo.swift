//
//  SpacerDemo.swift
//  SwiftUIDemo
//
//  Created by Knox on 2022/11/26.
//  Copyright © 2022 luoquan. All rights reserved.
//

import SwiftUI


// 一个灵活的填充空间布局，垂直/水平填充，默认填充满剩余所有空间，也可以指定填充的宽度或高度

struct SpacerDemo: View {
    var body: some View {
        HStack(
            alignment: .top,
            spacing: 10
        ) {
            Text("item0")
                .background(Color.red)
            Spacer()
            Text("item1")
                .background(Color.blue)
            Spacer()
            Text("item2")
                .background(Color.orange)
        }
    }
}

struct SpacerDemo_Previews: PreviewProvider {
    static var previews: some View {
        SpacerDemo()
    }
}
