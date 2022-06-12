//
//  DemoText.swift
//  SwiftDemo
//
//  Created by Knox on 2022/5/26.
//  Copyright © 2022 luoquan. All rights reserved.
//

import SwiftUI

@available(iOS 15, *)
let attr = try! AttributedString(markdown: "_Hamlet_ by William Shakespeare")

struct DemoText: View {
    var body: some View {
        if #available(iOS 15.0, *) {
            Text("+")
                .font(.title)
                .foregroundColor(.white)
                .padding()
                .background(Color.orange)

        } else {
            // Fallback on earlier versions
        }
            
            
    }
}

struct DemoText_Previews: PreviewProvider {
    static var previews: some View {
        DemoText()
    }
}
