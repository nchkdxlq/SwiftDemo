//
//  NavViewController.swift
//  SwiftDemo
//
//  Created by cookie.luo on 2023/3/25.
//  Copyright © 2023 luoquan. All rights reserved.
//

import UIKit
import SnapKit
import Combine

class NavViewController: EZBaseVC {

    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pushBtn = UIButton(type: .contactAdd)
        pushBtn.publisher(for: .touchUpInside)
            .sink(receiveValue: { _ in
                self.push()
            })
            .store(in: &cancellables)
        
        let popBtn = UIButton(type: .close)
        popBtn.publisher(for: .touchUpInside)
            .sink(receiveValue: { _ in
                self.pop()
            })
            .store(in: &cancellables)
        
        view.addSubview(pushBtn)
        view.addSubview(popBtn)
        pushBtn.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(-30)
        }
        popBtn.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(30)
        }
    }
    
    
    func push() {
        let vc = NavViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
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

