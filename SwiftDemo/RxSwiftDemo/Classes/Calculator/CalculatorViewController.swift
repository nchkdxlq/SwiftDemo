//
//  CalculatorViewController.swift
//  RxSwiftDemo
//
//  Created by Knox on 2019/10/13.
//  Copyright © 2019 luoquan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CalculatorViewController: BaseViewController {

    @IBOutlet weak var inputOne: UITextField!
    @IBOutlet weak var inputTwo: UITextField!
    @IBOutlet weak var inputThree: UITextField!
    
    @IBOutlet weak var result: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Calculator"
    
        Observable.combineLatest(inputOne.rx.text.orEmpty, inputTwo.rx.text.orEmpty, inputThree.rx.text.orEmpty) { (v1, v2, v3) -> Int in
                return (Int(v1) ?? 0) + (Int(v2) ?? 0) + (Int(v3) ?? 0)
            }.map { $0.description }
            .bind(to: result.rx.text)
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
