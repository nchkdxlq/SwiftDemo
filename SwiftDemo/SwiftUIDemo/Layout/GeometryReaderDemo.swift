//
//  GeometryReaderDemo.swift
//  SwiftUIDemo
//
//  Created by Knox on 2022/11/26.
//  Copyright © 2022 luoquan. All rights reserved.
//

import SwiftUI

struct GeometryReaderDemo: View {

    var body: some View {
//        Example1()
        Example2().frame(width: 200, height: 100, alignment: .center)
    }
}



struct Example1: View {
    
    @State private var w: CGFloat = 100
    @State private var h: CGFloat = 100
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                Text("w: \(geo.size.width, specifier: "%.1f") \n h: \(geo.size.height, specifier: "%.1f")")
            }
            .frame(width: w, height: h)
            .border(Color.green)

            Slider(value: self.$w, in: 10...300)
                .padding(.horizontal, 30)
        }
    }
}

struct Example2: View {
    
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 0) {
                Text("举个例子🌰, \(Int(proxy.size.width)) ")
//                    .layoutPriority(1)
                MyRectangle()
            }
            .border(Color.green, width: 1)
        }

    }

    struct MyRectangle: View {
        var body: some View {
            Rectangle().fill(Color.green)
        }
    }
}







struct GeometryReaderDemo_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderDemo()
    }
}
