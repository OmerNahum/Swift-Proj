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

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var usernameTxt: UITextField!
    
    @IBAction func passwordTxt(_ sender: Any) {
    }
    @IBAction func unwindToLogin(segue:UIStoryboardSegue){}

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
