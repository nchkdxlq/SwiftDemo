//
//  MessageRowDemo.swift
//  SwiftUIDemo
//
//  Created by Knox on 2022/11/27.
//  Copyright © 2022 luoquan. All rights reserved.
//

import SwiftUI

struct MessageRowDemo: View {
    
    struct Message {
        let initials: String
        let content: String
    }
    
    let message: Message
    
    var body: some View {
        HStack (
            alignment: .top, // alignment: child在HStack中垂直方向上的对齐方式
            spacing: 8 // spacing: 水平方向child之间的间隔
        ) {
            ZStack {
                Circle()
                    .fill(Color.yellow)
                    .border(Color.red)
                Text(message.initials)
            }
            .frame(width: 40)
            
            Text(message.content)
                .border(Color.blue)
        }
        .border(Color.red)
        .padding([.horizontal], 10)
        // alignment: frame的子View(padding)在frame中的对齐方式
        .frame(height: 200, alignment: .top)
        .border(Color.green)
    }
}

struct MessageRowDemo_Previews: PreviewProvider {
    static var previews: some View {
        let msg = MessageRowDemo.Message(
            initials: "MR",
            content: "When you add a frame modifier, SwiftUI wraps the affected view,With the alignment applied, you get an unexpected result."
        )
        MessageRowDemo(message: msg)
    }
}
