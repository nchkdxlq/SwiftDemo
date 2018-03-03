//
//  GestureRecognizerViewController.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 2016/12/31.
//  Copyright © 2016年 nchkdxlq. All rights reserved.
//

import UIKit

class GestureRecognizerViewController: EZBaseVC {

    var targetView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        targetView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        targetView.center = CGPoint(x: UIScreen.width/2.0, y: 100.0)
        targetView.backgroundColor = UIColor.red
        view.addSubview(targetView)
        
        let tap = UIPanGestureRecognizer(target: self, action: #selector(panHandle(_:)))
        targetView.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func panHandle(_ pan: UIPanGestureRecognizer) {
        let view = pan.view
        let point1 = pan.location(in: self.view)
        let point2 = pan.translation(in: self.view)
        view?.center = point1
//        pan.setTranslation(CGPoint.zero, in: self.view)
//        if let __view = view {
//            var resultPoint = __view.center
//            resultPoint.x += point2.x
//            resultPoint.y += point2.y
//            __view.center = resultPoint
//        }
        
//        print("point1\(point1)")
//        
//        if pan.state == .began {
//            print("beginPoint1: \(point1)")
//        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
