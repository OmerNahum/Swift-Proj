//
//  ChatViewController.swift
//  Project
//
//  Created by admin on 05/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    var group: Group?
    override func viewDidLoad() {
        super.viewDidLoad()
         let vc:GroupInfoViewController = GroupInfoViewController()
              vc.group = group;
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "GroupInfoSegue"){
            let vc: GroupInfoViewController = segue.destination as! GroupInfoViewController
            vc.group = group
            
        }
    }
  


}
