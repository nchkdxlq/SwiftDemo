//
//  EZBaseVC.swift
//  EZWeibo
//
//  Created by nchkdxlq on 4/28/16.
//  Copyright © 2016 nchkdxlq. All rights reserved.
//

import UIKit

class EZBaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        // Do any additional setup after loading the view.
    }

    
    func createLeftImageItem(image: String, highlightedImage: String, action: Selector)
    {
        navigationItem.leftBarButtonItem = createImageItem(image: image, highlightedImage: highlightedImage, action: action)
    }
    
    func createRightImageItem(image: String, highlightedImage: String, action: Selector)
    {
        navigationItem.rightBarButtonItem = createImageItem(image: image, highlightedImage: highlightedImage, action: action)
    }
    
    private func createImageItem(image: String, highlightedImage: String, action: Selector) -> UIBarButtonItem
    {
        let button = UIButton()
        button.setImage(UIImage(named: image), for: .normal)
        button.setImage(UIImage(named: highlightedImage), for: .highlighted)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.sizeToFit()
        return UIBarButtonItem(customView: button)
    }
    
    deinit
    {
        print("deinit\(self)")
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
