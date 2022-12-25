//
//  ViewConfigurationDemo.swift
//  SwiftUIDemo
//
//  Created by cookie.luo on 2022/12/1.
//  Copyright © 2022 luoquan. All rights reserved.
//

import SwiftUI

struct ViewConfigurationDemo: View {
    var body: some View {
//        OpacityDemo()
//        HiddenDemo()
        ToggleHiddenDemo()
    }
}

struct OpacityDemo: View {
    var body: some View {
        VStack() {
            Color.yellow
                .frame(width: 200, height: 200, alignment: .center)
                .zIndex(1)
                .opacity(0.5) // 设置透明度
            
            Color.red.frame(width: 200, height: 200, alignment: .center)
                .padding(-40)
        }
    }
}

struct HiddenDemo: View {
    var body: some View {
        HStack {
            Image(systemName: "a.circle.fill")
            Image(systemName: "b.circle.fill")
            Image(systemName: "c.circle.fill")
                .hidden() // 隐藏View但是还占据空间
            Image(systemName: "d.circle.fill")
        }
    }
}

struct ToggleHiddenDemo: View {
    @State var isHidden = false
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "a.circle.fill")
                Image(systemName: "b.circle.fill")
                if !isHidden {
                    Image(systemName: "c.circle.fill")
                }
                Image(systemName: "d.circle.fill")
            }
            .border(Color.green)
            Toggle("Hide", isOn: $isHidden)
                // .labelsHidden()// 隐藏文字
                .frame(width: 100)
                .border(Color.red)
        }
    }
}



struct ViewConfigurationDemo_Previews: PreviewProvider {
    static var previews: some View {
        ViewConfigurationDemo()
    }
}
