//
//  ImageDemo.swift
//  SwiftUIDemo
//
//  Created by Knox on 2022/11/27.
//  Copyright © 2022 luoquan. All rights reserved.
//

import SwiftUI

struct ImageDemo: View {
    var body: some View {
        Image(systemName: "sun.min.fill")
            .resizable()
            .frame(width: 40, height: 40)
    }
}


struct ImageDemo1: View {
    var body: some View {
        Image("footerball")
            .resizable() // 调整大小，以便填充所有可用空间
//             .aspectRatio(contentMode: .fit)
            .scaledToFit()
    }
}

struct ImageDemo2: View {
    var body: some View {
        VStack {
            Text("Footer Ball")
                .font(.largeTitle)
            Image("footerball")
                .resizable()
                .scaledToFit()
            Spacer()
        }
    }
}

struct ImageDemo3: View {
    var body: some View {
        Image("footerball")
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 300)
            .border(Color.red)
    }
}



struct ImageDemo_Previews: PreviewProvider {
    static var previews: some View {
//        ImageDemo2()
        ImageDemo3()
    }
}
