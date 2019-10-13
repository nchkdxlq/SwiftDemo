//
//  RegisterViewController.swift
//  RxSwiftDemo
//
//  Created by Knox on 2019/10/12.
//  Copyright © 2019 luoquan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class RegisterViewController: BaseViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var usernameTips: UILabel!
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordTips: UILabel!
    
    @IBOutlet weak var repeatedPassword: UITextField!
    @IBOutlet weak var repeatedPasswordTips: UILabel!
    
    @IBOutlet weak var registerButton: UIButton!
    
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "注册"
        
        let viewModel = RegisterViewModel(username: username.rx.text.orEmpty.asObservable(),
                                          password: password.rx.text.orEmpty.asObservable(),
                                          repeatedPassword: repeatedPassword.rx.text.orEmpty.asObservable(),
                                          registerTap: registerButton.rx.tap.asObservable())
        
        viewModel.usernameValidated
            .bind(to: usernameTips.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.passwordValidated
            .bind(to: passwordTips.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.passwordRepeatValidated
            .bind(to: repeatedPasswordTips.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.registerEnable.subscribe(onNext: { [weak self] enable in
            guard let `self` = self else { return }
            print("registeEnable:", enable)
            self.registerButton.isEnabled = enable
            self.registerButton.alpha = enable ? 1.0 : 0.5
        }).disposed(by: disposeBag)
    }

    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
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
