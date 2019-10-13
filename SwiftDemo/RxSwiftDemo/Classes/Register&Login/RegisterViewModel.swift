//
//  RegisterViewModel.swift
//  RxSwiftDemo
//
//  Created by Knox on 2019/10/12.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation
import RxSwift

struct RegisterViewModel {
    
    let usernameValidated: Observable<ValidationResult>
    let passwordValidated: Observable<ValidationResult>
    let passwordRepeatValidated: Observable<ValidationResult>
    let registerEnable: Observable<Bool>
    
    
    let registerTap = PublishSubject<Void>()
    
    init(username: Observable<String>,
         password: Observable<String>,
         repeatedPassword: Observable<String>,
         registerTap: Observable<Void>) {
        
        let api = GitHubAPI.sharedPAI
        let psdMinCount = 5
        
        //flatMapLatest 如果有新的值发射出来，则会取消原来发出的网络请求
        //flatMap 则不会
        usernameValidated = username.flatMapLatest { (account) -> Observable<ValidationResult> in
            // 是否为空
            if account.isEmpty {
                return Observable.just(.empty)
            }
            
            if account.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
                return Observable.just(.failed(message: "Username can only cantain numvers or digits"))
            }
            
            return api.usernameAvailable(account).map { (available) -> ValidationResult in
                if available {
                    return .ok(message: "Username available")
                } else {
                    return .failed(message: "Username already taken")
                }
            }.startWith(ValidationResult.validating)
                .observeOn(MainScheduler.instance)
                .catchErrorJustReturn(.failed(message: "Error contacting server"))
            
        }.share(replay: 1)
        
        
        passwordValidated = password.map {
            if $0.isEmpty {
                return .empty
            }

            if $0.count < psdMinCount {
                return .failed(message: "Password must be at least \(psdMinCount) characters")
            }
            
            return .ok(message: "Password acceptable")
        }.share(replay: 1)
        
//        usernameValidated = username.map {
//            $0.count > 0 ? .ok(message: "验证通过") : .empty
//        }.share(replay: 1)
        
//        passwordValidated = password.map {
//            $0.count > 0 ? .ok(message: "验证通过") : .empty
//        }.share(replay: 1)
        
        passwordRepeatValidated = Observable.combineLatest(password, repeatedPassword) {
            if $1.isEmpty {
                return .empty
            }
            if $0 != $1 {
                return .failed(message: "两次输入的密码不一致")
            }
            return .ok(message: "验证通过")
        }.share(replay: 1)
        
        
        registerEnable = Observable.combineLatest(usernameValidated, passwordValidated, passwordRepeatValidated) {
            return $0.isValid && $1.isValid && $2.isValid
        }
        .distinctUntilChanged() // 当只有值改变的时候才会发射事件
        .share(replay: 1)
        
    }
    
}
