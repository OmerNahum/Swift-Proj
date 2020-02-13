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



class NewGroupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,CNContactPickerDelegate {
    
    
    var  selectedImage: UIImage?;
    var contacts:String? = "";
    
    
    
    @IBOutlet weak var groupName: UITextField!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var contactsScrollView: UIScrollView!
    
    @IBOutlet weak var addPicBtn: UIButton!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    @IBOutlet weak var createBtn: UIButton!
    
    @IBOutlet weak var addContactBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activity.isHidden = true;
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addContactBtn(_ sender: Any) {
        let contactPicker = CNContactPickerViewController();
        contactPicker.delegate = self;
        contactPicker.displayedPropertyKeys = [CNContactGivenNameKey, CNContactPhoneNumbersKey];
        self.present(contactPicker,animated: true, completion: nil);
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
        self.addContactBtn.isEnabled = false;
        
        if let selectedImage = selectedImage {
            Model.instance.saveImage(image: selectedImage) { (url) in
                
                let group = Group(name: self.groupName.text!, image: url!, participants: self.contacts!);
                Model.instance.add(group: group){
                    self.navigationController?.popViewController(animated: true);
                }
            }
            // todo no pic
        }else{
            let group = Group(name: self.groupName.text!, image: "", participants: self.contacts! );
            Model.instance.add(group: group){ 
                self.navigationController?.popViewController(animated: true);
            }
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
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage;
        self.image.image = selectedImage;
        dismiss(animated: true, completion: nil);
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        
        for contact in contacts{
            print(contact.givenName);
            print(contact.phoneNumbers[0].value);
            self.contacts?.append(contentsOf: contact.givenName + ",");
        }
        dismiss(animated: true, completion: nil);
    }
}
