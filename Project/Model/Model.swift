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
    
    
//    private init(){
//        modelsql.setLastUpdateDate(name: "GROUPS", lud: 13)
//        let lud = modelsql.getLastUpdateDate(name: "GROUPS")
//        print("\(lud)")
//    }
    
    //var groups = [Group]()
    
    
    func add(group: Group, callback: @escaping () -> Void){
        //modelsql.add(group: group)
        modelFirebase.add(group: group,callback: callback)
    }
    
    func getAllGroups(callback: @escaping ([Group]?) -> Void){
        
        
        //get the current user:
        
        let user = Auth.auth().currentUser
        var usersGroups = [Group]()
        
        
        // get the local last update
        let lud = modelsql.getLastUpdateDate(name: "GROUPS")

         //get the records from firebase since the local last update data
        modelFirebase.getAllGroups(since:lud) { (groupData) in
             //save the new record to the local db
            var localLud: Int64 = 0;
            for group in groupData!{
                self.modelsql.add(group: group)
                if(group.lastUpdate > localLud){
                    localLud = group.lastUpdate
                }
            }
            
        //save the new local last update date

            self.modelsql.setLastUpdateDate(name: "GROUPS", lud: localLud)


        //get the groups from the local db
            let groups = self.modelsql.getAllGroups();

        //return the complete groups to the user that logged on.

             for group in groups{
                let part = group.participants
                    if(part.contains((user?.email)!)){
                    usersGroups.append(group)
                        }
                    }
            
            
                callback(usersGroups)
        }
    }
    
    
    func deleteGroup(group:Group, callback: @escaping () -> Void){
    modelsql.delete(group: group)
      modelFirebase.deleteGroup(group: group, callback: callback)
        
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

    
  
}


