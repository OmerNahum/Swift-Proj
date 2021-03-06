//
//  NewGroupViewController.swift
//  Project
//
//  Created by admin on 09/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import ContactsUI
import Foundation



class NewGroupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource{
    
    
    var  selectedImage: UIImage?;
    
    @IBOutlet weak var groupName: UITextField!
    
    @IBOutlet weak var image: UIImageView!
    
    
    @IBOutlet weak var addPicBtn: UIButton!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    @IBOutlet weak var createBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addError: UILabel!
    
    @IBOutlet weak var participantTxt: UITextField!
    
    @IBOutlet weak var existError: UILabel!
    @IBAction func addBtn(_ sender: Any) {
        
        self.addError.isHidden = true
        self.existError.isHidden = true
        
        Model.instance.searchUser(userName: participantTxt.text!){ (user:User?) in
            if(user != nil){
                if(!self.emails.contains(self.participantTxt.text!)){
                    self.emails.append(self.participantTxt.text!)
                }
                else{
                    self.existError.isHidden = false
                }
                self.tableView.reloadData()
            }else{
                self.addError.isHidden = false
            }
            
            
        }
    }
    @IBOutlet weak var addBtnOutlet: UIButton!
    var emails = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        existError.isHidden = true
        addError.isHidden = true
        activity.isHidden = true;
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:newGroupTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! newGroupTableViewCell
        let part = emails[indexPath.row]
        cell.textLabel!.text = part
        return cell
    }
    
    
    
    @IBAction func addPictureBtn(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerController.SourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func CreateBtn(_ sender: Any) {
        
        self.createBtn.isEnabled = false;
        self.activity.isHidden = false;
        self.addPicBtn.isEnabled = false;
        self.addBtnOutlet.isEnabled = false;
        
        
        
        if let selectedImage = selectedImage {
            Model.instance.saveImage(image: selectedImage) { (url) in
                let group = Group(name: self.groupName.text!, image: url!, participants: self.emails);
                Model.instance.add(group: group){
                    self.navigationController?.popViewController(animated: true);
                }
            }
            // todo no pic
        }else{
            let group = Group(name: self.groupName.text!, image: "", participants: self.emails);
            Model.instance.add(group: group){
                self.navigationController?.popViewController(animated: true);
            }
            emails.removeAll()
        }
        
        
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage;
        self.image.image = selectedImage;
        dismiss(animated: true, completion: nil);
    }
    
    
    
    
    
    
    
    
    
}
