//
//  LoginViewController.swift
//  RxSwiftDemo
//
//  Created by Knox on 2019/10/10.
//  Copyright © 2019 luoquan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

enum LoginTestError : Error {
    case httpError
}



class LoginViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var usernameTips: UILabel!
    
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var passwordTips: UILabel!
    
    @IBOutlet weak var actionButton: UIButton!
    
    
    @IBOutlet weak var successButton: UIButton!
    @IBOutlet weak var failureButton: UIButton!
    @IBOutlet weak var successCount: UILabel!
    @IBOutlet var failureCount: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "登录"
        
        errorHandle()
        
        usernameTips.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordTips.text = "Password has to be at least \(minimalPasswordLength) characters"
        
        
        let usernameValid = usernameInput.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1)
        
        let passwordValid = passwordInput.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)
        // 没看懂 { $0 && $1} 是什么意思, 解释：combineLatest 接收三个参数，第三个参数是尾随闭包 { (value1, value2) in return value1 && value2 }
        let allValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        usernameValid.bind(to: passwordInput.rx.isEnabled).disposed(by: disposeBag)
        usernameValid.bind(to: usernameTips.rx.isHidden).disposed(by: disposeBag)
        
        passwordValid.bind(to: passwordTips.rx.isHidden).disposed(by: disposeBag)
    
        allValid.bind(to: actionButton.rx.isEnabled).disposed(by: disposeBag)
        
        actionButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.showAlert()
        }).disposed(by: disposeBag)
    }
    
    
    func showAlert() {
        
        let alertC = UIAlertController(title: "RxExample", message: "This is wonderful", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertC.addAction(cancel)
        
        present(alertC, animated: true, completion: nil)
    }
    
    
    func errorHandle() {
        
        /*
        
         疑问
         1. successTap、failureTap是局部变量，没有保持，为什么没有释放？
         2. fatMap产生的Observer也没有保存，收到`onError`事件后，为什么就不能再发出事件了, 不是每次都是新的Observer吗？？
         
         
         */
        
        let successTap = successButton.rx.tap.map { return true }
        let failureTap = failureButton.rx.tap.map { return false }
        
        Observable.merge(successTap, failureTap).flatMap { (value) -> Observable<Void> in
             return Observable.create { (observer) -> Disposable in
                print("Observable.create")
                if value {
                    observer.onNext(())
                } else {
                    observer.onError(LoginTestError.httpError)
                }
                return Disposables.create()
            }
        }.subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
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
