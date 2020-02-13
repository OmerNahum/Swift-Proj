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
    
    

}
