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
    @IBOutlet weak var backgroundVIew: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundVIew.image = UIImage(named: "background")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard UserDefaults.standard.object(forKey: "user") != nil else { return }
        self.performSegue(withIdentifier: "openMainViewFromLogin", sender: nil)
    }
    
    @IBAction func onClickLogin(_ sender: UIButton) {
        login()
    }
    
    private func login() {
        self.performSegue(withIdentifier: "openRegisterView", sender: nil)
    }
}
