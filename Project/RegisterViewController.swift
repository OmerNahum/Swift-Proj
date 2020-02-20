//
//  RegisterViewController.swift
//  Project
//
//  Created by admin on 18/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errLabel.isHidden = true
        activityReg.isHidden = true;
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var passwordVar: UITextField!
    @IBOutlet weak var fullNameTxt: UITextField!
    @IBOutlet weak var errLabel: UILabel!
    @IBOutlet weak var registerOutlet: UIButton!
    @IBOutlet weak var activityReg: UIActivityIndicatorView!
    
    @IBAction func registerBtn(_ sender: Any) {
        registerOutlet.isEnabled = false
        activityReg.isHidden = false;
        if(passwordTxt.text! == passwordVar.text!){
            Model.instance.addUser(user: User(name: fullNameTxt.text!, email: userNameTxt.text!,password: passwordTxt.text!)){
                
                (success) in
                if (success == true){
                    self.activityReg.isHidden = true;
                    self.dismiss(animated: true, completion: nil)
                }
                else{
                    self.errLabel.isHidden = false
                    self.registerOutlet.isEnabled = true
                    self.activityReg.isHidden = true;
                }
            }
        }
        else{
            self.errLabel.isHidden = false
            self.registerOutlet.isEnabled = true
            self.activityReg.isHidden = true;
        }
    }
    
    
}
