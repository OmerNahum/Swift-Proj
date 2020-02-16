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
    @IBOutlet weak var addPartOutlet: UIButton!
    @IBOutlet weak var wrongUserLabel: UILabel!
    @IBOutlet weak var alreadyExistLabel: UILabel!
    @IBAction func deletePartBtn(_ sender: Any) {
        self.editUser(string: "delete")
    }
    @IBOutlet weak var deletePartOutlet: UIButton!
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
        deleteGroupOutlet.isEnabled = false
        deletePartOutlet.isEnabled = false
        addPartOutlet.isEnabled = false
        
        group?.name = infoName!.text!
        if(selectedImage != nil){
            Model.instance.saveImage(image: self.selectedImage!){ url in
                self.group?.image = url!
                
            }
        }
        Model.instance.editGroup(group: group!){
            self.navigationController?.popViewController(animated: true);
        }
        
        
    }
    @IBOutlet weak var saveOutlet: UIButton!
    @IBOutlet weak var deleteGroupOutlet: UIButton!
    @IBAction func deleteGroup(_ sender: Any) {
        saveOutlet.isEnabled = false
        deletePartOutlet.isEnabled = false
        addPartOutlet.isEnabled = false
        for part in group!.participants{
            Model.instance.searchUser(userName: part){ user in
                if let user = user {
                    Model.instance.deleteUser(user: user, group: self.group!){}
                }
            }
        }
        Model.instance.deleteGroup(group: group!){
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
            viewControllers[viewControllers.count - 3].viewDidLoad()
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
        alreadyExistLabel.isHidden = true
        wrongUserLabel.isHidden = true
        if(string == "add" && group!.participants.contains(addOrDeleteTxt.text!)){
            alreadyExistLabel.isHidden = false
        }
        else{
            Model.instance.searchUser(userName: addOrDeleteTxt.text!){ (user:User?) in
                if let user = user {
                    if(string == "add"){
                        self.group?.participants.append(self.addOrDeleteTxt.text!)
                        Model.instance.addUserByOther(user: user, group: self.group!){}
                    }
                    else{
                        print("before delete")
                        self.group?.participants.removeAll(where: {$0 == self.addOrDeleteTxt.text})
                        Model.instance.deleteUser(user: user, group: self.group!){}
                        print("DELETED FROM PARTICIPANTS")
                    }
                }else{
                    self.wrongUserLabel.isHidden = false
                }
                self.tableView.reloadData()
            }
            self.tableView.reloadData()
        }
        
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
