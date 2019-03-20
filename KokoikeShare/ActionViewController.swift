//
//  ActionViewController.swift
//  KokoikeShare
//
//  Created by mosin on 2019/03/18.
//  Copyright © 2019 mosin. All rights reserved.
//

import UIKit
import MobileCoreServices
import WebKit
import Alamofire


class ActionViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    @IBOutlet weak var uiWebView: UIWebView!
    
    override func loadView() {
       
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "kkik://")
        let req = URLRequest(url: myURL!)
        uiWebView.loadRequest(req)
        //uiWebView.load(req, mimeType: <#String#>)
        
        // Get the item[s] we're handling from the extension context.
        
        // For example, look for an image and place it into an image view.
        // Replace this with something appropriate for the type[s] your extension supports.
//        var imageFound = false
//        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
//            for provider in item.attachments! as! [NSItemProvider] {
//                if provider.hasItemConformingToTypeIdentifier(kUTTypeImage as String) {
//                    // This is an image. We'll load it, then place it in our image view.
//                    //weak var weakImageView = self.imageView
//                    provider.loadItem(forTypeIdentifier: kUTTypeImage as String, options: nil, completionHandler: { (imageURL, error) in
//                        print(imageURL)
//                    })
//
//                    imageFound = true
//                    break
//                }
//            }
//
//            if (imageFound) {
//                // We only handle one image, so stop looking for more.
//                break
//            }
//        }
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }

}
