//
//  FrameDemo.swift
//  SwiftUIDemo
//
//  Created by Knox on 2022/11/26.
//  Copyright © 2022 luoquan. All rights reserved.
//

import SwiftUI


// 效果与预期不一致
struct Frame1: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .background(Color.orange)
            .frame(width: 200, height: 50)
    }
}

// 调整顺序，预期一直 frame为子View提供建议的size
struct Frame2: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .frame(width: 200, height: 50)
            .background(Color.orange)
    }
}

/*
 frame中的alignment会对其内部的views做整体的对齐处理，
 在平时的开发中，如果你发现，在frame中设置了alignment，但并没有起作用，
 主要原因是外边的容器，比如说HStack，VStack等他们自身的尺寸刚好等于其子views的尺寸，
 这种情况下的alignment效果都是一样的。
 */
struct Frame3: View {
    var body: some View {
        HStack {
            Text("Good job.")
                .background(Color.orange)
        }
        .frame(width: 300, height: 200, alignment: .topLeading)
        .border(Color.green)
    }
}


/*
 
 idealWidth和idealHeight，按照字面意思，ideal是理想的意思，那么当我们为某个view设置了idealWidth后会怎样呢？
 实际上，这个ideal必须跟.fixedSize(horizontal: true, vertical: true)一起使用才行：
 horizontal：表示固定水平方向，也就是idealWidth
 vertical： 表示固定垂直方向，也就是idealHeight
 
 */
struct Frame4: View {
    var body: some View {
        VStack(
            spacing: 30
        ) {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .frame(idealWidth: 200, idealHeight: 100)
                .fixedSize(horizontal: true, vertical: false)
                .border(Color.orange)
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .frame(idealWidth: 200, idealHeight: 100)
                .fixedSize(horizontal: false, vertical: true)
                .border(Color.orange)
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .frame(idealWidth: 200, idealHeight: 100)
                .fixedSize(horizontal: true, vertical: true)
                .border(Color.orange)
        }
    }
}

/*
 
 1. 同时设置了minWidth和maxWidth，background的size返回300：
 2. 如果只设置了minWidth，那么background的size返回300：
 3. 只要设置了maxWidth，background返回的就是maxWidth的值
 
 */
struct Frame5: View {
    var body: some View {
        Text("Hello, World!")
//            .frame(minWidth: 40, maxWidth: 300)
//            .frame(minWidth: 300)
            .frame(maxWidth: 300)
            .background(Color.orange.opacity(0.5))
            .font(.largeTitle)
    }
}


struct Frame6: View {
    var body: some View {
        Text("这个文本还挺长的，到达了一定字数后，就超过了一行的显示范围了！！！")
            .frame(idealWidth: 300)
            .fixedSize(horizontal: true, vertical: false)
            .border(Color.blue)
            .frame(width: 200, height: 100)
            .border(Color.green)
            .font(.title)
    }
}

/*
 
 ### SwiftUI中布局的三个原则
 
 1. 父view为子view提供一个建议的size
 2. 子view根据自身的特性，返回一个实际需要的size
 3. 父view根据子view返回的size为其进行布局
 
 
 */
struct FrameDemo: View {
    var body: some View {
//        Frame1()
//        Frame2()
//        Frame3()
//        Frame4()
//        Frame5()
        Frame6()
    }
}

struct FrameDemo_Previews: PreviewProvider {
    static var previews: some View {
        FrameDemo()
    }
}
