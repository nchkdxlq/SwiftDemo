//
//  RxSwiftTestViewController.swift
//  RxSwiftDemo
//
//  Created by Knox on 2019/9/29.
//  Copyright © 2019 luoquan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxSwiftTestViewController: BaseViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let btn = UIButton(frame: CGRect(x: 100, y: 300, width: 100, height: 50))
        btn.setTitle("Button", for: .normal)
        btn.backgroundColor = UIColor.blue
        view.addSubview(btn)
        
        btn.rx.tap
        .subscribe(onNext: {
            print("button Tapped")
        })
        .disposed(by: disposeBag)
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
