//
//  User.swift
//  Project
//
//  Created by Studio on 13/02/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation


class User {
    var email: String = ""
    var id: String = ""
    var groups:[Group]?
    var password:String = ""
    
    init(email:String, password:String) {
        self.email = email
        self.password = password
        
    }
    
    
    func toJson() -> [String:Any] {
        var json = [String:Any]();
        json["id"] = self.id
        json["email"] = self.email;
        json["groups"] = self.groups;
        json["password"] = self.password;
        //json["lastUpdate"] = FieldValue.serverTimestamp();
        return json
      }
    
}
