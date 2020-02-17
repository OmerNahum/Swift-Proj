//
//  Model.swift
//  Project
//
//  Created by admin on 05/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Model {
    static let instance = Model()
    
    var modelsql:ModelSql = ModelSql();
    var modelFirebase:ModelFirebase = ModelFirebase();
    
    
    private init(){
        
    }
    
    //var groups = [Group]()
    
    
    func add(group: Group, callback: @escaping () -> Void){
        //modelsql.add(group: group)
        modelFirebase.add(group: group,callback: callback)
    }
    
    func getAllGroups(callback: @escaping ([Group]?) -> Void){
        
        
        //get the current user:
        
        let user = Auth.auth().currentUser
        
        
        
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
        
        modelFirebase.getAllGroups(){(groups: [Group]?) in
            var usersData = [Group]();
            if let groups = groups{
                for group in groups{
                     let part = group.participants
                           if(part.contains((user?.email)!)){
                            usersData.append(group)
                           }
                }
                callback(usersData)
            }
        }
        
        }
    
    
        
    
    
    
    func saveImage(image: UIImage, callback: @escaping (String?)-> Void ){
        FirebaseStorage.saveImage(image: image, callback: callback)
    }
    
    func addUser(user:User, callback: @escaping (Bool) -> Void) {
        modelFirebase.addUser(user: user, callback: callback)
    }
    
    func login(user:User, callback: @escaping (Bool) -> Void) {
           modelFirebase.login(user: user, callback: callback)
    }
    func searchUser(userName:String, callback: @escaping (User?) -> Void) {
        modelFirebase.searchUser(userName: userName,callback: callback)
    }
    func editUser(name:String, image:String,callback: @escaping () -> Void){
        modelFirebase.editUser(name: name,image: image, callback: callback)
    }
    func currentUser(callback: @escaping (User) -> Void){
        modelFirebase.currentUser(callback: callback)
    }
    func editGroup(group:Group,callback: @escaping () -> Void){
        modelFirebase.editGroup(group:group, callback: callback)
     }
    func deleteUser(user:User, group:Group, callback: @escaping () -> Void){
        modelFirebase.deleteUser(user: user, group: group, callback: callback)
    }
    func addUserByOther(user:User, group:Group, callback: @escaping () -> Void){
        modelFirebase.addUserByOther(user: user, group: group, callback: callback)
    }
    func deleteGroup(group:Group, callback: @escaping () -> Void){
        modelFirebase.deleteGroup(group: group, callback: callback)
    }
    
  
}


