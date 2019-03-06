//
//  RegisterViewController.swift
//  Kokoike
//
//  Created by mosin on 2019/02/25.
//  Copyright © 2019 mosin. All rights reserved.
//

import UIKit
import Foundation
import WebKit
import SwiftyJSON

class RegisterViewController: UIViewController, WKUIDelegate, WKNavigationDelegate  {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        var webFrame: CGRect = .zero
        webFrame.origin.y = navBarHeight! + statusBarHeight
        
        webView = WKWebView(frame: webFrame, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: API.sharedInstance.getAuthURL())
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        webView.evaluateJavaScript(
            "document.getElementsByTagName('pre')[0].innerText",
            completionHandler: { (text: Any?, error: Error?) in
                if let text = text as? String {
                    self.registUserToDevice(responseBody: text)
                    self.performSegue(withIdentifier: "openMainViewFromRegister", sender: nil)
                }
        }
        )
    }
    
    func registUserToDevice(responseBody: String) {
        let json = JSON.init(parseJSON: responseBody)
        let keys = [
            Constants.USER_KEYS.ID,
            Constants.USER_KEYS.DISPLAY_NAME,
            Constants.USER_KEYS.SCREEN_NAME,
            Constants.USER_KEYS.TWITTER_ID,
            Constants.USER_KEYS.ICON_URL
        ]

        for key in keys {
            if key == "id" {
                UserDefaults.standard.set(json[key].intValue, forKey: key)
            } else {
                UserDefaults.standard.set(json[key].stringValue, forKey: key)
            }
            print(key + " was added to user defaults")
        }
    }
}
