//
//  TestViewController.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 6/18/16.
//  Copyright © 2016 nchkdxlq. All rights reserved.
//

import UIKit

class TestViewController: EZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        let btn = UIButton(frame: CGRect(x: 50, y: 100, width: 100, height: 30))
        view.addSubview(btn)
        btn.setTitle("default", for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        
        btn.setTitle("hileighted", for: .highlighted)
        btn.setTitleColor(UIColor.orange, for: .highlighted)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
