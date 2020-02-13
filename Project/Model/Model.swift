//
//  Model.swift
//  Project
//
//  Created by admin on 05/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

class Model {
    static let instance = Model()
    
    var modelsql:ModelSql = ModelSql();
    var modelFirebase:ModelFirebase = ModelFirebase();
    
    
    private init(){
    }
    
    var data = [Group]()
    
    
    func add(group: Group, callback: @escaping () -> Void){
        //modelsql.add(group: group)
        modelFirebase.add(group: group,callback: callback)
    }
    
    func getAllGroups(callback: @escaping ([Group]?) -> Void){
        
        // get the local last update
//        let lud = modelsql.getLastUpdateDate(id: "GROUPS")
//
//        // get the records from firebase since the local last update data
//        modelFirebase.getAllGroups(since:lud) { (groupData) in
//             //save the new record to the local db
//            var localLud: Int64 = 0;
//            for group in groupData!{
//                self.modelsql.add(group: group)
//                if(group.lastUpdate > localLud){
//                    localLud = group.lastUpdate
//                }
//            }
//        //save the new local last update date
//
//            self.modelsql.setLastUpdateDate(id: "GROUPS", lud: localLud)
//
//
//        //get the complete data from the local db
//            let completeData = self.modelsql.getAllGroups();
//
//        //return the complete data to the caller
//
//            callback(completeData);
         modelFirebase.getAllGroups(callback: callback);
        
        }
    
        
    
    
    
    func saveImage(image: UIImage, callback: @escaping (String?)-> Void ){
        FirebaseStorage.saveImage(image: image, callback: callback);
    }
    
    func addUser(user:User, callback: @escaping (Bool) -> Void) {
        modelFirebase.addUser(user: user, callback: callback)
    }
    
    func login(user:User, callback: @escaping (Bool) -> Void) {
           modelFirebase.login(user: user, callback: callback)
    }
    func searchUser(userName:String, callback: @escaping (Bool) -> Void) {
        modelFirebase.searchUser(userName: userName,callback: callback)
    }

}


