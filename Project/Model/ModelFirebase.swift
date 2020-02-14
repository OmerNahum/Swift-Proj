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
        // var ref: DocumentReference? = nil
        //        var ref: DocumentReference? = nil
        let user  = Auth.auth().currentUser
        group.participants.append(user!.email!)
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
                            let groups = User(name: "",email: part, password: document!.get("password") as! String)
                            groups.groups = document!.get("groups") as! [String]
                            groups.groups.append(db2.documentID)
                          
                            
                            document?.reference.updateData([
                                "groups": groups.groups
                            ])
                        }
                    }
                    
                }
            }
            
            
        }
        
        
        //        ref = db.collection("groups").addDocument(data:group.toJson(), completion: { err in
        //            if let err = err {
        //                print("Error adding document: \(err)")
        //            } else {
        //                print("Document added with ID: \(ref!.documentID)")
        //                ModelEvents.GroupDataEvent.post();
        //            }
        //        })
        callback()
    }
    
    
    
    func getAllGroups(/*since: Int64*/callback: @escaping ([Group]?)->Void){
        
        //        db.collection("groups").order(by: "lastUpdate").start(at: [
        //            Timestamp(seconds: since, nanoseconds: 0)]).getDocuments { (querySnapshot, err) in
        //               if let err = err {
        //                   print("Error getting documents: \(err)")
        //                   callback(nil);
        //               } else {
        //                   var data = [Group]();
        //                   for document in querySnapshot!.documents {
        //                    data.append(Group(json: document.data()));
        //                   }
        //                   callback(data);
        //               }
        //           };
        
        let user = Auth.auth().currentUser
        db.collection("groups").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                callback(nil);
            } else {
                var data = [Group]();
                for document in querySnapshot!.documents {
                    let part = document.get("participants") as! [String]
                    if(part.contains((user?.email)!)){
                        data.append(Group(json: document.data(),id: document.documentID));
                    }
                }
                callback(data);
            }
        };
    }
    
    
    func addUser(user: User, callback: @escaping (Bool) -> Void){
        // var ref: DocumentReference? = nil
        //        var ref: DocumentReference? = nil
        
        
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
    
    //        ref = db.collection("groups").addDocument(data:group.toJson(), completion: { err in
    //            if let err = err {
    //                print("Error adding document: \(err)")
    //            } else {
    //                print("Document added with ID: \(ref!.documentID)")
    //                ModelEvents.GroupDataEvent.post();
    //            }
    //        })
    func searchUser(userName: String, callback: @escaping (Bool) -> Void){
        db.collection("users").whereField("email", isEqualTo: userName).getDocuments(){(querySnapshot,err) in
            if let err = err{
                print("Error getting user: \(err)")
                callback(false)
            }else{
                if(querySnapshot?.count == 1){
                    callback(true)
                }
                else{callback(false)}
            }
            
            
        }
    }
    func editUser(name:String, image:String,callback: @escaping () -> Void){
        let user = Auth.auth().currentUser
        
        db.collection("users").whereField("email", isEqualTo: user?.email).getDocuments(){(querySnapShot, err) in
            if let err = err{
                print("error finding user: \(err)")
            }else{
                let doc = querySnapShot?.documents.first
                doc?.reference.updateData([
                    "name" : name,
                    "image": image
                ])
            }
        }
        callback()
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
    
}

