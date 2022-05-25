//
//  MiscViewController.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2019/7/18.
//  Copyright © 2019 luoquan. All rights reserved.
//

import UIKit

class Dog: NSObject {
    
}


class MiscViewController: EZBaseVC {
    
//    var button1: UIButton
//    var button2: UIButton
    
    var dog1: Dog?
    var dog2: Dog?
    
    
    let mapTable = NSMapTable<Dog, Dog>(keyOptions: .weakMemory, valueOptions: .weakMemory)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button1 = UIButton()
        button1.setTitle("button1", for: .normal)
        button1.addTarget(self, action: #selector(tapAction(button:)), for: .touchUpInside)
        button1.setTitleColor(.blue, for: .normal)
        view.addSubview(button1)
        button1.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.centerX.equalTo(view)
        }
        
        
        let button2 = UIButton()
        button2.setTitleColor(.blue, for: .normal)
        button2.addTarget(self, action: #selector(tapAction(button:)), for: .touchUpInside)
        button2.setTitle("button2", for: .normal)
        view.addSubview(button2)
     
        button2.snp.makeConstraints { (make) in
            make.top.equalTo(button1.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
        
        dog1 = Dog()
        dog2 = Dog()
        
        mapTable.setObject(dog2, forKey: dog1)
        dog2 = nil
    }
    
    
    @objc func tapAction(button: UIButton) {
        let test1 = mapTable.object(forKey: dog1)
        print(test1 ?? "dog is nil")
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
