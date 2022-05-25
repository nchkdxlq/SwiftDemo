//
//  SwiftUIViewController.swift
//  SwiftDemo
//
//  Created by Knox on 2022/5/24.
//  Copyright © 2022 luoquan. All rights reserved.
//

import SwiftUI


struct SwiftHomeView: View {
    var body: some View {
        List {
            Button("Text") {
                print("Text Clicked")
            }
            Button("Button") {
                print("Button Clicked")
            }
        }
    }
}


class SwiftUIViewController: UIHostingController<SwiftHomeView> {
    
    static func hostingController() -> UIHostingController<SwiftHomeView> {
        return UIHostingController(rootView: SwiftHomeView())
    }
    
}
