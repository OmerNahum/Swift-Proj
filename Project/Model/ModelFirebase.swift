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
        let json = group.toJson()
        db.collection("groups").document().setData(json){
            err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                ModelEvents.GroupDataEvent.post();
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
        
        db.collection("groups").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                callback(nil);
            } else {
                var data = [Group]();
                for document in querySnapshot!.documents {
                    data.append(Group(json: document.data(),id: document.documentID));
                }
                callback(data);
            }
        };
    }
    
    
    
    func getGroupsCount(callback: @escaping (Int)->Void){
        print(db.collection("groups").accessibilityElementCount())
        callback(db.collection("groups").accessibilityElementCount());
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
            Auth.auth().signIn(withEmail: user.email, password: user.password) { [weak self] authResult, error in
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
        
        
}

