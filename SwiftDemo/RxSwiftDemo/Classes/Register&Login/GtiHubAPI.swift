//
//  GtiHubAPI.swift
//  RxSwiftDemo
//
//  Created by Knox on 2019/10/13.
//  Copyright © 2019 luoquan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class GitHubAPI {
    
    let urlSession: URLSession
    
    static let sharedPAI = GitHubAPI(urlSession: URLSession.shared)
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
 
    
    func usernameAvailable(_ username: String) -> Observable<Bool> {
        let url = URL(string: "https://github.com/\(username)")!
        let request = URLRequest(url: url)
        
        return self.urlSession.rx.response(request: request)
            .map { (response, _) in
                return response.statusCode == 404
            }.catchErrorJustReturn(false)
    }
    
}
