//
//  LoginViewController.swift
//  Project
//
//  Created by admin on 18/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errLabel.isHidden = true
        activityLogin.isHidden = true;
        
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func unwindToLogin(segue:UIStoryboardSegue){}
    @IBOutlet weak var errLabel: UILabel!
    @IBOutlet weak var loginOutlet: UIButton!
    @IBOutlet weak var activityLogin: UIActivityIndicatorView!
    
    
    @IBAction func logInBtn(_ sender: Any) {
        loginOutlet.isEnabled = false;
        activityLogin.isHidden = false;
        Model.instance.login(user: User(email: usernameTxt.text!,password: password.text!)){
            
            (success) in
            if (success == true){
                self.activityLogin.isHidden = true;
                self.loginOutlet.isEnabled = true
                self.performSegue(withIdentifier: "LoginSegue", sender: self)
            }
            else{
                self.errLabel.isHidden = false
                self.loginOutlet.isEnabled = true;
                self.activityLogin.isHidden = true
            }
        }
    }
    
}
