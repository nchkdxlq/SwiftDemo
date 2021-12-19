//
//  WKWebViewController.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/8/2.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import UIKit
import WebKit

class WKWebViewController: UIViewController {
//    BDUSS
    fileprivate var webView: WKWebView!
    private let navigationDelegate = WKNavigationDelegateImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
        setupRightItem()
        loadRequest()
        
        logCookies()
    }

    private func logCookies() {
        let httpCookies = HTTPCookieStorage.shared.cookies ?? [];
        httpCookies.forEach({ cookie in
            print("1httpCookies - \(cookie.name):\(cookie.value), domain = \(cookie.domain), path = \(cookie.path)")
        })
    
        let httpCookieStore = WKWebsiteDataStore.default().httpCookieStore
        httpCookieStore.getAllCookies { cookieList in
            cookieList.forEach({ cookie in
//                httpCookieStore.delete(cookie, completionHandler: nil)
                print("2httpCookies - \(cookie.name):\(cookie.value), domain = \(cookie.domain), path = \(cookie.path)")
            })
        }
    }
    
    
    fileprivate func setupWebView() {
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.uiDelegate = self
        webView.navigationDelegate = navigationDelegate
        view.addSubview(webView)
        webView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    
    fileprivate func loadRequest() {
        guard let url = URL(string: "https://www.baidu.com") else { return }
        let request = URLRequest(url: url)
        self.webView.load(request)
        return
        
        let storage = HTTPCookieStorage.shared
        let httpCookieStore = WKWebsiteDataStore.default().httpCookieStore
        
        if let cookies = storage.cookies {
            for item in cookies {
                if item.name == "BDUSS" {
                    httpCookieStore.setCookie(item) {
                        self.webView.load(request)
                    }
                    break
                }
            }
        }
    }
    
    private func firstLoadSetCookie() {
        guard let url = URL(string: "https://www.baidu.com") else { return }
        var request = URLRequest(url: url)
        let storage = HTTPCookieStorage.shared
        if let cookies = storage.cookies {
            for item in cookies {
                if item.name == "BDUSS" {
                    let fields = HTTPCookie.requestHeaderFields(with: [item])
                    request.allHTTPHeaderFields = fields
                    break
                }
            }
        }
        webView.load(request)
    }
    
    
    fileprivate func setupRightItem() {
        let item = UIBarButtonItem(title: "刷新",
                                   style: .done,
                                   target: self,
                                   action: #selector(refreshAction))
        navigationItem.rightBarButtonItem = item
    }
    
    @objc private func refreshAction() {
        webView.reload()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



extension WKWebViewController : WKUIDelegate {
    
}

