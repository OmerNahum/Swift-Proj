//
//  GroupInfoViewController.swift
//  Project
//
//  Created by admin on 05/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class GroupInfoViewController: UIViewController,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate {
    
    
    
    
    
    
    var selectedImage:UIImage?
    @IBOutlet weak var infoName: UITextField!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBAction func addPartBtn(_ sender: Any) {
        self.editUser(string: "add")
    }
    @IBOutlet weak var wrongUserLabel: UILabel!
    @IBOutlet weak var alreadyExistLabel: UILabel!
    @IBAction func deletePartBtn(_ sender: Any) {
        self.editUser(string: "delete")
    }
    @IBAction func changePicBtn(_ sender: Any) {
        
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
    @IBAction func saveBtn(_ sender: Any) {
        group?.name = addOrDeleteTxt.text!
        if(selectedImage != nil){
            Model.instance.saveImage(image: self.selectedImage!){ url in
                self.group?.image = url!
                
            }
        }
        Model.instance.editGroup(group: group!){
            self.navigationController?.popViewController(animated: true);
        }
        
        
    }
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addOrDeleteTxt: UITextField!
    
    var group: Group?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wrongUserLabel.isHidden = true
        alreadyExistLabel.isHidden = true
        
        infoName.text = group?.name
        image.image = UIImage(named: "avatar")
        
        if(group?.image != ""){
            image.kf.setImage(with: URL(string: group!.image));
        }
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group!.participants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:newGroupTableViewCell = tableView.dequeueReusableCell(withIdentifier: "infoGroupCell", for: indexPath) as! newGroupTableViewCell
        let part = group!.participants[indexPath.row]
        cell.textLabel!.text = part
        return cell
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage;
        self.image.image = selectedImage;
        dismiss(animated: true, completion: nil);
    }
    func editUser(string:String){
        
        
        if(string == "add" && group!.participants.contains(addOrDeleteTxt.text!)){
            alreadyExistLabel.isHidden = false
        }
        else{
            Model.instance.searchUser(userName: addOrDeleteTxt.text!){ success in
                if(!success){
                    self.wrongUserLabel.isHidden = false
                }else{
                    if(string == "add"){
                        self.group?.participants.append(self.addOrDeleteTxt.text!)
                        
                    }
                    else{
                        print("before delete")
                            
                        }
                        print("DELETED FROM PARTICIPANTS")
                    }
                }
                
            }
        Model.instance.editUser(name: self.addOrDeleteTxt.text!, image: ""){}
        self.tableView.reloadData()
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
