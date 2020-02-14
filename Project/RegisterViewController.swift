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
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var userNameTxt: UITextField!
    
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    
    @IBOutlet weak var passwordVar: UITextField!
    
    @IBOutlet weak var fullNameTxt: UITextField!
    
    @IBOutlet weak var errLabel: UILabel!
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func registerBtn(_ sender: Any) {
        if(passwordTxt.text! == passwordVar.text!){
            Model.instance.addUser(user: User(name: fullNameTxt.text!, email: userNameTxt.text!,password: passwordTxt.text!)){
                
                (success) in
                if (success == true){
                    self.dismiss(animated: true, completion: nil)
                }
                else{
                    self.errLabel.isHidden = false
                }
            }
        }
        else{
            self.errLabel.isHidden = false
        }
    }
    
    
}
