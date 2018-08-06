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

    fileprivate var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
        setupRightItem()
        loadRequest()
    }

    fileprivate func setupWebView() {
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view.addSubview(webView)
        webView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    
    fileprivate func loadRequest() {
        guard let url = URL(string: "https://www.baidu.com") else { return }
        let request = URLRequest(url: url)
        var cookieArr = [HTTPCookie]()
        let storage = HTTPCookieStorage.shared
        if let cookies = storage.cookies,
            let host = url.host {
            for item in cookies {
                if host.contains(item.name) {
                    cookieArr.append(item)
                }
            }
        }
        if cookieArr.count > 0 {
            let cookie = HTTPCookie.requestHeaderFields(with: cookieArr)
            print(cookie)
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


extension WKWebViewController : WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
        print("decidePolicyFor navigationAction")
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
        print("decidePolicyFor navigationResponse")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("didCommit navigation")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("didFail navigation")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish navigation")
    }
    
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("didReceive challenge")
        completionHandler(.useCredential, nil)
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("didReceiveServerRedirectForProvisionalNavigation")
    }
    
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print("webViewWebContentProcessDidTerminate")
    }
}

extension WKWebViewController : WKUIDelegate {
    
}

