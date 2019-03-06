//
//  LoginViewController.swift
//  Kokoike
//
//  Created by mosin on 2019/02/25.
//  Copyright © 2019 mosin. All rights reserved.
//

import UIKit
import Foundation

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBOutlet weak var backgroundVIew: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundVIew.image = UIImage(named: "background")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        if UserDefaults.standard.object(forKey: "user") != nil {
//            print("user defaults object is not null!")
//            self.performSegue(withIdentifier: "openMainViewFromLogin", sender: nil)
//
//        } else {
//            print("user defaults object is null!")
//        }
    }
    
    @IBAction func onClickLogin(_ sender: UIButton) {
        print("onClickLoginButton")
        login()
    }
    
    private func login() {
//        if let username = userNameInput.text {
//            print(username)
//            saveToUserDefaults(username: username)
//        }
//
//        if let password = passwordInput.text {
//            print(password)
//        }
//
//        self.performSegue(withIdentifier: "openMainViewFromLogin", sender: nil)
        self.performSegue(withIdentifier: "openRegisterView", sender: nil)
    }
    
    private func saveToUserDefaults(username: String) {
        UserDefaults.standard.set(username, forKey: "user")
    }
    
    
    @IBAction func onClickRegister(_ sender: UIButton) {
        print("onClickRegisterButton")
       
    }
}
