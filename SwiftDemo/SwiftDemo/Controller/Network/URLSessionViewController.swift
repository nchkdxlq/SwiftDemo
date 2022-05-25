//
//  URLSessionViewController.swift
//  SwiftDemo
//
//  Created by Knox on 2020/11/12.
//  Copyright © 2020 luoquan. All rights reserved.
//

import UIKit

class URLSessionViewController: EZBaseVC {

    let sessionDelegate = URLSessionDelegateImp()
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config, delegate: sessionDelegate, delegateQueue: OperationQueue.main)
        
        return session
    }()
    
    
    var task: URLSessionDataTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    func createGETRequest() {
        let url = URL(string: "https://www.baidu.com")!
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request)
        
        task.resume();
        
//        self.task = task
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        createGETRequest()
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
