//
//  User.swift
//  Project
//
//  Created by Studio on 13/02/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import Firebase


class User {
    var name: String = ""
    var image: String = ""
    var email: String = ""
    var id: String = ""
    var groups:[String] = []
    var password:String = ""
    
    init(name:String, email:String, password:String) {
        self.name = name
        self.email = email
        self.password = password
        
        
    }
    
    init(email:String, password:String) {
        self.email = email
        self.password = password
        
    }
    init(json:[String:Any]){
        self.id = json["id"] as! String;
        self.name = json["name"] as! String;
        self.image = json["image"] as! String;
        self.email = json["email"] as! String
        self.groups = json["groups"] as! [String]
        self.password = json["password"] as! String
        
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]();
        json["id"] = self.id
        json["email"] = self.email;
        json["groups"] = self.groups;
        json["password"] = self.password;
        json["name"] = self.name
        json["image"] = self.image
        return json
    }
    
    
}
