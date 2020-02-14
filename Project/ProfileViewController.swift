//
//  ProfileViewController.swift
//  Project
//
//  Created by admin on 26/12/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    var selectedImage:UIImage?;
    
    var user:User?
    
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Model.instance.currentUser(){(user:User?) in
            if let user = user{
                self.email.text = user.email
                self.nameTxt.text = user.name
            }
        }
        
        // Do any additional setup after loading the view.
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage;
          self.image.image = selectedImage;
          dismiss(animated: true, completion: nil);
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
    @IBAction func saveBtn(_ sender: Any) {
         
         if let selectedImage = selectedImage {
             Model.instance.saveImage(image: selectedImage) { (url) in
                Model.instance.editUser(name: self.nameTxt.text!, image: url!){
                    self.navigationController?.popViewController(animated: true);

                }
             }
        }
    }
//    @IBAction func nameText(_ sender: UITextField) {
//    }
//    @IBAction func statusText(_ sender: UITextField) {
//    }
//    @IBAction func numberText(_ sender: UITextField) {
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
