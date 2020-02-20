//
//  FirebaseStorage.swift
//  Project
//
//  Created by admin on 14/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class FirebaseStorage{
    
    
    static func saveImage(image:UIImage, callback:@escaping (String?)->Void){
        
        let storageRef = Storage.storage().reference(forURL:"gs://groupsproj.appspot.com")
        let data = image.jpegData(compressionQuality: 0.8)
        let imageRef = storageRef.child(image.description);
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        imageRef.putData(data!, metadata: metadata) { (metadata, error) in
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    return
                }
                print("url: \(downloadURL)")
                callback(downloadURL.absoluteString)
            }
        }
    }
    
    
}
