//
//  GroupWithFireBase.swift
//  Project
//
//  Created by admin on 21/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import Firebase

extension Group{
    convenience init(json:[String:Any]){
        let id = json["id"] as! Int64;
        self.init(id: Int(id))

        name = json["name"] as! String;
        image = json["image"] as! String;
        let ts = json["lastUpdate"] as! Timestamp
        lastUpdate = ts.seconds
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]();
        json["id"] = id
        json["name"] = name
        json["image"] = image
        json["lastUpdate"] = FieldValue.serverTimestamp()
        return json;
    }
    
}
