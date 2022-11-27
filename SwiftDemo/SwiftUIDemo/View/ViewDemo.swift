//
//  ViewDemo.swift
//  SwiftUIDemo
//
//  Created by Knox on 2022/11/27.
//  Copyright © 2022 luoquan. All rights reserved.
//

import SwiftUI

/// 所有View都有的属性设置
struct ViewDemo: View {
    var body: some View {
        Rectangle()
            .fill(Color.yellow.opacity(0.7))
            .frame(width: 100, height: 100) // 控件的大小
            .padding(20) // 相对子View是外边距，相对于父View是内边距
            .background(Color.blue) // 背景
            .cornerRadius(30) // 圆角
            .border(Color.red, width: 2) // 边框
            .onTapGesture(count: 1) {
                print("被点击了")
            }
            .onLongPressGesture(
                minimumDuration: 2,
                perform: {
                    print("长按了")
                }
            ) { state in
                print("长按状态改变了", state)
            }
    }
}

struct ViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        ViewDemo()
    }
}
