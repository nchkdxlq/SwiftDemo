//
//  StackViewController.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2019/5/13.
//  Copyright © 2019 luoquan. All rights reserved.
//

import UIKit

class StackViewController: BaseViewController {
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let bgView = UIView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 100))
        view.addSubview(bgView)
        bgView.backgroundColor = UIColor.gray
        
        let contannerView = UIStackView(frame: bgView.bounds)
        contannerView.axis = .horizontal
        contannerView.alignment = .center
        contannerView.distribution = .fill
        contannerView.spacing = 10
        bgView.addSubview(contannerView)
        
        let red = UILabel()
        red.text = "red"
        red.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        red.backgroundColor = UIColor.red
        contannerView.addArrangedSubview(red);
        
        let green = UILabel()
        green.text = "green"
        green.backgroundColor = UIColor.green
        contannerView.addArrangedSubview(green);
        
        let blue = UILabel()
        blue.text = "blue"
        blue.backgroundColor = UIColor.blue
        contannerView.addArrangedSubview(blue);
        
        setupTimer()
    }
    
    
    func setupTimer() {
//        timer = Timer(fireAt: Date.init(timeIntervalSinceNow: 10), interval: 3.0, target: self, selector: #selector(timerHandle), userInfo: nil, repeats: true)
        timer = Timer(timeInterval: 3.0, target: self, selector: #selector(timerHandle), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .commonModes)
//        timer?.fire()
        print("setup  - \(Date().timeIntervalSince1970)");
    }
    
    
    @objc func timerHandle() {
        print("handle - \(Date().timeIntervalSince1970)");
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
