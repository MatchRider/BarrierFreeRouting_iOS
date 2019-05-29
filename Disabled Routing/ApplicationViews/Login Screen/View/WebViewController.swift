//
//  WebViewController.swift
//  Hürdenlose Navigation
//
//  Created by Hürdenlose Navigation on 11/06/18.
//  Copyright © 2018 Hürdenlose Navigation. All rights reserved.
//

import UIKit
import WebKit
import OAuthSwift
class WebViewController: OAuthWebViewController {
  
    @IBOutlet weak var viewBackground: UIView!
    var webViewLogin: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.webViewLogin.navigationDelegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.setUpWkWebView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func setUpWkWebView()
    {
        self.webViewLogin.frame = self.viewBackground.bounds
        self.viewBackground.addSubview(self.webViewLogin)
    }
    override func handle(_ url: URL) {
        self.webViewLogin = WKWebView()
        //Development
        
//        let urlRequest = URLRequest(url: URL(string: "https://master.apis.dev.openstreetmap.org/oauth/authorize")!)
           let urlRequest = URLRequest(url: URL(string: "https://www.openstreetmap.org/oauth/authorize")!)
        self.webViewLogin.load(urlRequest)
    }
}
extension WebViewController:WKNavigationDelegate
{
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        if(navigationAction.navigationType == .formSubmitted)
//        {
//            if navigationAction.request.url != nil
//            {
//                //do what you need with url
//                //self.delegate?.openURL(url: navigationAction.request.url!)
//            }
//            decisionHandler(.cancel)
//            return
//        }
        print(navigationAction.request.url!)
        decisionHandler(.allow)
    }
}
