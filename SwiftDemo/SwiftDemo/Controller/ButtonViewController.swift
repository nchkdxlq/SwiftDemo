//
//  ButtonViewController.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 2016/12/11.
//  Copyright © 2016年 nchkdxlq. All rights reserved.
//

import UIKit
import SnapKit


class LQButton: UIButton {
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print(#function)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        print(#function)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        print(#function)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        print(#function)
    }
    
}







class ButtonViewController: EZBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let button = LQButton()
        view.addSubview(button)
        button.backgroundColor = UIColor.red
        button.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(300)
            make.centerX.equalTo(self.view)
            make.size.equalTo(CGSize(width: 200, height: 50))
        }
        
        button.addTarget(self, action: #selector(ButtonViewController.touchDown(_:)),
                         for: .touchDown)
        button.addTarget(self, action: #selector(ButtonViewController.touchUpInside(_:)),
                         for: .touchUpInside)
        button.addTarget(self, action: #selector(ButtonViewController.touchUpOutside(_:)),
                         for: .touchUpOutside)
        button.addTarget(self, action: #selector(ButtonViewController.touchDragEnter(_:)),
                         for: .touchDragEnter)
        button.addTarget(self, action: #selector(ButtonViewController.touchDragExit(_:)),
                         for: .touchDragExit)
        button.addTarget(self, action: #selector(ButtonViewController.touchDragInside(_:)),
                         for: .touchDragInside)
        button.addTarget(self, action: #selector(ButtonViewController.touchDragOutside(_:)),
                         for: .touchDragOutside)
        button.addTarget(self, action: #selector(ButtonViewController.touchCancel(_:)),
                         for: .touchCancel)
    }

    @objc private func touchDown(_ button: UIButton) {
        print(#function)
    }
    
    @objc private func touchUpInside(_ button: UIButton) {
        print(#function)
    }
    
    @objc private func touchUpOutside(_ button: UIButton) {
        print(#function)
    }
    
    @objc private func touchDragEnter(_ button: UIButton) {
        print(#function)
    }
    
    @objc private func touchDragExit(_ button: UIButton) {
        print(#function)
    }
    
    @objc private func touchDragInside(_ button: UIButton) {
        print(#function)
    }
    
    @objc private func touchDragOutside(_ button: UIButton) {
        print(#function)
    }
    
    @objc private func touchCancel(_ button: UIButton) {
        print(#function)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
