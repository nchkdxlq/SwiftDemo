//
//  CombineViewController.swift
//  SwiftDemo
//
//  Created by Knox on 2023/3/15.
//  Copyright © 2023 luoquan. All rights reserved.
//

import UIKit
import Combine

class CombineViewController: EZBaseVC {

    private var sub: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let test = Just(5).map { value in
            return "\(value)"
        }.sink { value in
            print("收到的值：\(value)")
        }
        let pub = NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification, object: nil)
        let ret1 = pub.receive(on: DispatchQueue.main)
        let ret2 = ret1.sink { value in
            print(value.userInfo)
        }
        sub = ret2
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
