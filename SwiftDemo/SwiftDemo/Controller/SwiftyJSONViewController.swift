//
//  SwiftyJSONViewController.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 2016/12/4.
//  Copyright © 2016年 nchkdxlq. All rights reserved.
//

import UIKit
import SwiftyJSON


class SwiftyJSONViewController: EZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        let str = "{\"name\": \"luoquan\", \"age\": 25, \"gender\": \"male\"}"
        
        let jsonObject = JSON(str)
        
        // 方式1
        let result = jsonObject.dictionaryValue
        print(result["name"]?.string ?? "name is nil")
        
        // 方式2
        let dicResult = jsonObject.rawValue as? [String: Any] ?? [:]
        print(dicResult["name"] ?? "name is nil")
        
        // 通过上面对比，方式1 会简单一些
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
