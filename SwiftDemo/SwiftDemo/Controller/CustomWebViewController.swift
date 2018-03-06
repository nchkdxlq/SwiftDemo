//
//  CustomWebViewController.swift
//
//  Created by nchkdxlq on 2017/2/22.
//  Copyright © 2017年 nchkdxlq. All rights reserved.
//

import UIKit
import WebKit
import SwiftyJSON


class CustomWebViewController: UIViewController {
    
    var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setCookie()
        
        let config = WKWebViewConfiguration()
        webView = WKWebView(frame: view.bounds, configuration: config)
        view.addSubview(webView)
        webView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        webView.uiDelegate = self
        webView.navigationDelegate = self
        loadWebView()
    }
    
    private func loadWebView() {
        let url = URL(string: "http://www.baidu.com")!
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    
    
    func setCookie() {
        
        let fullURL = "http://www.baidu.com"
        let hostPort = 8080
        
        let user_uuid = "user_uuid"
        let device_type = "device_type"
        let device_sn = "device_sn"
        let time = "\(Int(Date().timeIntervalSince1970))"
        let signContent = user_uuid + device_type + device_sn + time
        
        let authInfo: [String: Any] = ["user_uuid": user_uuid,
                                       "device_type": device_type,
                                       "device_sn": device_sn,
                                       "time": time,
                                       "sign": signContent]
        
        let authValue = ""//JSON(authInfo).rawString()?.base64Encode() ?? ""
        print("authValue = " + authValue)
        
        var cookieProperties = [HTTPCookiePropertyKey : Any]()
        cookieProperties[HTTPCookiePropertyKey.name] = "auth"
        cookieProperties[HTTPCookiePropertyKey.value] = authValue
        cookieProperties[HTTPCookiePropertyKey.expires] = Date(timeIntervalSinceNow: 50.0)
        cookieProperties[HTTPCookiePropertyKey.domain] = "*"
        cookieProperties[HTTPCookiePropertyKey.originURL] = fullURL
        cookieProperties[HTTPCookiePropertyKey.path] = "/"
        cookieProperties[HTTPCookiePropertyKey.version] = "0"
        cookieProperties[HTTPCookiePropertyKey.port] = hostPort
        cookieProperties[HTTPCookiePropertyKey.discard] = 0
        
        if let cookies = HTTPCookieStorage.shared.cookies {
            cookies.forEach({ (item) in
                print(item)
                HTTPCookieStorage.shared.deleteCookie(item)
            })
        }
        
        HTTPCookieStorage.shared.cookieAcceptPolicy = .always
        if let cookie = HTTPCookie(properties: cookieProperties) {
            HTTPCookieStorage.shared.setCookie(cookie)
        }
        

        if let cookies = HTTPCookieStorage.shared.cookies {
            cookies.forEach({ (item) in
                print(item)
            })
        }
        
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


extension CustomWebViewController: WKUIDelegate {
    
}

extension CustomWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print(#function)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print(#function)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print(#function)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(#function)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(#function)
        print(error)
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        if let response = navigationResponse.response as? HTTPURLResponse {
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: response.allHeaderFields as! [String : String], for: response.url!)
            
            cookies.forEach({ (item) in
                print(item)
            })
        }
        
    }
    
}







