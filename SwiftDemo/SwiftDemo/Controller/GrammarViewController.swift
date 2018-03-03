//
//  GrammarViewController.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 5/14/16.
//  Copyright © 2016 nchkdxlq. All rights reserved.
//

import UIKit
import SwiftyJSON

class GrammarViewController: EZBaseVC {


    override func viewDidLoad() {
        super.viewDidLoad()
        
//        structSize()
//        testPoint()
        
        
        let closure = ClosureSyntax()
        closure.testClosureExpression()
        
        
        let name = "luoquangsdf;lhks;hk;dflhjklkfgjhkldjghdklfghjd;lfhjldkfg;hjd;lfjhd'hjdkdfg;lhkd;fhkd;fkjd;jk;ldkh;dlhkgd"
        
//        print(name.md5)
//        print(name.sha1)
//        print(name.hmac(algorithm: .SHA1, key: "111"))
        
    }
    

    
    
    
    
    
    func structSize()
    {
        let size = SomeSize(width: 100, height: 200)
        var size1 = size
        size1.width = 177
        print(size)
        print(size1)
    }
    
    
    func studentClass()
    {
        let st = Student(name: "cookie", age: 26)
        print("name = \(String(describing: st.name)), age = \(st.age)")
        st.age = 20
        print("age = \(st.age)")
    }
    
    
    func testPoint()
    {
        var point = Point(x: 1, y: 29)
        point.addedByX(detalX: 12, detalY: 11)
        print("point.x = \(point.x), point.y = \(point.y)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
