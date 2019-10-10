//
//  LoginViewController.swift
//  RxSwiftDemo
//
//  Created by Knox on 2019/10/10.
//  Copyright © 2019 luoquan. All rights reserved.
//

import UIKit


private let minimalUsernameLength = 5
private let minimalPasswordLength = 5


class LoginViewController: BaseViewController {
    
    lazy var username: UITextField = {
        let textField = UITextField()
        
        return textField
    }()
    
    lazy var usernameTipsz: UILabel = {
        let label = UILabel()
        label.text = "Username has to be at least \(minimalUsernameLength) characters"
        return label
    }()
    
    lazy var password: UITextField = {
        let textField = UITextField()
        
        return textField
    }()
    
    lazy var passwordTips: UILabel = {
        let label = UILabel()
        label.text = "Password has to be at least \(minimalPasswordLength) characters"
        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "登录"
        
        
    }
    
    
    private func setupSubViews() {
        
        
        
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
