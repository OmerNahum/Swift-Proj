//
//  GroupInfoViewController.swift
//  Project
//
//  Created by admin on 05/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class GroupInfoViewController: UIViewController {

    
    @IBOutlet weak var infoName: UITextField!
    
    @IBOutlet weak var image: UIImageView!
    
    var group: Group?
    override func viewDidLoad() {
        super.viewDidLoad()
        infoName.text = group?.name
        image.image = UIImage(named: "avatar")
        
        if(group?.image != ""){
            image.kf.setImage(with: URL(string: group!.image));
        }
        
        // Do any additional setup after loading the view.
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
