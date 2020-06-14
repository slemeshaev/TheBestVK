//
//  VkLoginViewController.swift
//  TheBestVK
//
//  Created by Станислав Лемешаев on 14.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class VkLoginViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.load(urlComponents())
        
    }
    
    // function of urlComponents
    func urlComponents() -> URLRequest {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "6793336"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "270342"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.92")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        return request
    }

}

extension VkLoginViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponce: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponce.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        print(params)
        
        guard let token = params["access_token"], let userId = Int(params["user_id"]!) else {
            decisionHandler(.cancel)
            return
        }
        
        print(token, userId)
        
        Session.shared.token = token
        Session.shared.userId = userId
        
        decisionHandler(.cancel)
        
        performSegue(withIdentifier: "VKLogin", sender: nil)
        
    }
}
