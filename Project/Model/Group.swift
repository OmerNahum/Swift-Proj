//
//  Group.swift
//  Project
//
//  Created by admin on 05/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import ContactsUI
import Firebase

class Group{
    var id: String = ""
    var name:String = ""
    var image:String = ""
    var participants:[String] = []
//    var lastUpdate: Int64 = 0;
    
    init(/*id:String,*/ name:String, image:String, participants:[String]){
        //self.id = id;
        self.name = name;
        self.image = image;
        self.participants = participants;
    }
    init(json:[String:Any],id:String){
        self.id = id;
        self.name = json["name"] as! String;
        self.image = json["image"] as! String;
        self.participants = json["participants"] as! [String];
        //let ts = json["lastUpdate"] as! Timestamp
        //self.lastUpdate = ts.seconds
        
    }
    init(json:[String:Any]){
        self.id = json["id"] as! String;
        self.name = json["name"] as! String;
        self.image = json["image"] as! String;
        self.participants = json["participants"] as! [String];
        //let ts = json["lastUpdate"] as! Timestamp
        //self.lastUpdate = ts.seconds
        
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]();
        json["id"] = id;
        json["name"] = name;
        json["image"] = image;
        json["participants"] = participants;
        //json["lastUpdate"] = FieldValue.serverTimestamp();
        return json;
      }
}
