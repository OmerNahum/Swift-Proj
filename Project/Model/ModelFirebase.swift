//
//  ModelFirebase.swift
//  Project
//
//  Created by admin on 09/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import Firebase

class ModelFirebase{
    
    let db = Firestore.firestore()
    
    func add(group: Group, callback: @escaping () -> Void){
        let user  = Auth.auth().currentUser
        if(!group.participants.contains((user?.email)!)){
            group.participants.append(user!.email!)
        }
        let json = group.toJson()
        let db2 = db.collection("groups").document()
        db2.setData(json){
            err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                ModelEvents.GroupDataEvent.post();
                db2.updateData([
                    "id": db2.documentID
                ])
                for part in group.participants {
                    self.db.collection("users").whereField("email", isEqualTo: part).getDocuments(){(querySnapshot,err) in
                        if let err = err{
                            print("error finding user: \(err)")
                        }else{
                            let document = querySnapshot!.documents.first
                            self.searchUser(userName: part){user in
                                if let user = user{
                                    user.groups = document!.get("groups") as! [String]
                                    user.groups.append(db2.documentID)
                                    
                                    
                                    document?.reference.updateData([
                                        "groups": user.groups
                                    ])
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        
        callback()
    }
    
    
    
    func getAllGroups(since: Int64,callback: @escaping ([Group]?)->Void){
        
        db.collection("groups").order(by: "lastUpdate").start(at: [
            Timestamp(seconds: since, nanoseconds: 0)]).getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    callback(nil);
                } else {
                    var data = [Group]();
                    for group in querySnapshot!.documents {
                        data.append(Group(json: group.data(),id: group.documentID));
                    }
                    callback(data);
                }
        };
        
    }
    
    
    func addUser(user: User, callback: @escaping (Bool) -> Void){
        
        
        Auth.auth().createUser(withEmail: user.email, password: user.password){authResult,error in
            if let err = error {
                print("Error in auth: \(err)")
                callback(false)
            }else{
                user.id = authResult!.user.uid
                let json = user.toJson()
                self.db.collection("users").document().setData(json){
                    err in
                    if let err = err {
                        print("Error writing document: \(err)")
                        callback(false)
                    } else {
                        print("Document successfully written!")
                        callback(true)
                    }
                }
            }
            
        }
    }
    
    func login(user: User, callback: @escaping (Bool) -> Void){
        Auth.auth().signIn(withEmail: user.email, password: user.password) { [weak self ] authResult, error in
            if let err = error{
                print("Login error: \(err)")
                callback(false)
            }else{
                print("Logged in")
                callback(true)
            }
            
        }
    }
    

    
    func searchUser(userName: String, callback: @escaping (User?) -> Void){
        var user:User?
        db.collection("users").whereField("email", isEqualTo: userName).getDocuments(){(querySnapshot,err) in
            if let err = err{
                print("Error getting user: \(err)")
                callback(user)
            }else{
                if(querySnapshot?.count == 1){
                    callback(User(json: (querySnapshot?.documents.first?.data())!))
                }
                else{callback(user)}
            }
            
            
        }
    }
    func editUser(name:String, image:String,callback: @escaping () -> Void){
        let user = Auth.auth().currentUser
        let group = db.collection("groups")
        db.collection("users").whereField("email", isEqualTo: user?.email).getDocuments(){(querySnapShot, err) in
            if let err = err{
                print("error finding user: \(err)")
                
            }else{
                let doc = querySnapShot?.documents.first
                doc?.reference.updateData([
                    "name" : name,
                    "image": image,
                    "lastUpdate" : FieldValue.serverTimestamp()
                ])
                
            }
        }
        callback()
    }
    func deleteUser(user:User, group:Group, callback: @escaping () -> Void){
        db.collection("users").whereField("email", isEqualTo: user.email).getDocuments(){(querySnapShot, err) in
            if let err = err{
                print("error finding user: \(err)")
                
            }else{
                let doc = querySnapShot?.documents.first
                doc?.reference.updateData([
                    "groups": user.groups.filter({$0 != group.id})
                ])
                callback()
                
            }
        }
        
    }
    func addUserByOther(user:User, group:Group, callback: @escaping () -> Void){
        user.groups.append(group.id)
        db.collection("users").whereField("email", isEqualTo: user.email).getDocuments(){(querySnapShot, err) in
            if let err = err{
                print("error finding user: \(err)")
                
            }else{
                let doc = querySnapShot?.documents.first
                doc?.reference.updateData([
                    "groups": user.groups
                ])
                callback()
                
            }
        }
        
    }
    func currentUser(callback: @escaping (User) -> Void){
        let user = Auth.auth().currentUser
        db.collection("users").whereField("email", isEqualTo: user?.email).getDocuments(){(querySnapShot, err) in
            if let err = err{
                print("error finding user: \(err)")
            }else{
                let doc = querySnapShot?.documents.first
                let user1 = User(name: doc?.get("name") as! String, email: user!.email!, password: "")
                callback(user1)
            }
        }
        
    }
    func editGroup(group:Group,callback: @escaping () -> Void){
        
        db.collection("groups").whereField("id", isEqualTo: group.id).getDocuments(){(querySnapShot, err) in
            if let err = err{
                print("error finding user: \(err)")
                
            }else{
                let doc = querySnapShot?.documents.first
                doc?.reference.updateData([
                    "id": group.id,
                    "image": group.image,
                    "name" : group.name,
                    "participants": group.participants,
                    "lastUpdate" : FieldValue.serverTimestamp()
                    
                    
                ])
                
            }
        }
        callback()
        
    }
    
    func deleteGroup(group:Group, callback: @escaping () -> Void) {
        
        db.collection("groups").whereField("id", isEqualTo: group.id).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    document.reference.delete()
                }
                callback()
            }
        }
        
    }
    
}
