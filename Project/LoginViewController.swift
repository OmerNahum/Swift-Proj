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
        
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var usernameTxt: UITextField!
    
   
    @IBOutlet weak var password: UITextField!
    
    @IBAction func unwindToLogin(segue:UIStoryboardSegue){}

    
    @IBOutlet weak var errLabel: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func logInBtn(_ sender: Any) {
        
        Model.instance.login(user: User(email: usernameTxt.text!,password: password.text!)){
                      
                      (success) in
                      if (success == true){
                        self.performSegue(withIdentifier: "LoginSegue", sender: self)
                      }
                      else{
                          self.errLabel.isHidden = false
                      }
                  }
              }
    
}
