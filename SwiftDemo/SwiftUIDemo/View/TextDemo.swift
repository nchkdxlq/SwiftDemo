//
//  TextDemo.swift
//  SwiftUIDemo
//
//  Created by Knox on 2022/11/27.
//  Copyright © 2022 luoquan. All rights reserved.
//

import SwiftUI

struct TextDemo: View {
    var body: some View {
        Text("Swift 5.7 引入了另一组巨大的语言变化和改进，包括正则表达式等强大功能、速记语法等生活质量改进")
            .strikethrough(true, color: Color.orange) // 中划线
            .underline(true, color: Color.blue) // 下划线
            .italic()
            .font(.system(size: 24, weight: .regular)) // 字体
            .kerning(6) // 字间距
            .lineSpacing(12) // 行间距
            .lineLimit(2) // 限制最大行数，默认会自动折行
            .foregroundColor(Color.red) // 文本颜色
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)) // 内边距
            .background(Color.green) // 背景色
            .cornerRadius(16) // 圆角
            .onTapGesture {
                print("Text点击了")
            }
    }
}

struct TextDemo_Previews: PreviewProvider {
    static var previews: some View {
        TextDemo()
    }
}
