//
//  ModelSql.swift
//  Project
//
//  Created by admin on 05/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

class ModelSql{
    
    var database: OpaquePointer? = nil
    
    init(){
         let dbFileName = "database2.db"
         if let dir = FileManager.default.urls(for: .documentDirectory, in:
        .userDomainMask).first{
             let path = dir.appendingPathComponent(dbFileName)
             if sqlite3_open(path.absoluteString, &database) != SQLITE_OK {
                 print("Failed to open db file: \(path.absoluteString)")
                 return
            }
            
        }
        create();
    }
    
    func create(){
        var errormsg: UnsafeMutablePointer<Int8>? = nil
        
        var res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS GROUPS(GROUP_ID TEXT PRIMARY KEY, NAME TEXT,IMAGE TEXT, PARTICIPANTS TEXT)", nil, nil, &errormsg);
         if(res != 0){
             print("error creating table");
             return
         }
        res = sqlite3_exec(database, "DROP TABLE LAST_UPDATE_DATE", nil, nil, &errormsg);
         res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS LAST_UPDATE_DATE(ID TEXT PRIMARY KEY, LUD TEXT)", nil, nil, &errormsg);
        if(res != 0){
            print("error creating table");
            return
        }
    }
    func add(group: Group){
        var sqlite3_stmt: OpaquePointer? = nil
        if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO GROUPS(GROUP_ID, NAME, IMAGE, PARTICIPANTS) VALUES (?,?,?,?);",-1,&sqlite3_stmt,nil) == SQLITE_OK){
           // let id = group.id?.description.cString(using: .utf8);
            let name = group.name.cString(using: .utf8);
            let image = group.image.cString(using: .utf8);
            //let participants = group.participants.cString(using: .utf8);

            //sqlite3_bind_text(sqlite3_stmt, 1, id,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 2, name,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 3, image,-1,nil);
            //sqlite3_bind_text(sqlite3_stmt, 4, participants,-1,nil);
            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                print("new row added succefully")
            }
        }
    }
    
    func getAllGroups()->[Group]{
        var sqlite3_stmt: OpaquePointer? = nil
         var data = [Group]()
         if (sqlite3_prepare_v2(database,"SELECT * from GROUPS;",-1,&sqlite3_stmt,nil)
        == SQLITE_OK){
             while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let id = String(cString:sqlite3_column_text(sqlite3_stmt,0)!);
                let name = String(cString:sqlite3_column_text(sqlite3_stmt,1)!);
                let image = String(cString:sqlite3_column_text(sqlite3_stmt,2)!);
                
               let participants = String(cString:sqlite3_column_text(sqlite3_stmt,3)!);
                
                //data.append(Group(id:Int(id)!, name:name, image:image,participants: participants));
             }
         }
         sqlite3_finalize(sqlite3_stmt)
         return data
    }
    
    
    
    func setLastUpdateDate(id: String, lud: Int64){
          var sqlite3_stmt: OpaquePointer? = nil
          if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO LAST_UPDATE_DATE(ID, LUD) VALUES (?,?);",-1,&sqlite3_stmt,nil) == SQLITE_OK){

            sqlite3_bind_text(sqlite3_stmt, 1, id.cString(using: .utf8),-1,nil);
            sqlite3_bind_int64(sqlite3_stmt, 2, lud);
              if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                  print("new row added succefully")
              }
          }
      }
    
    
    func getLastUpdateDate(id: String)->Int64{
         var sqlite3_stmt: OpaquePointer? = nil
        var lud:Int64 = 0;
          if (sqlite3_prepare_v2(database,"SELECT * from LAST_UPDATE_DATE;",-1,&sqlite3_stmt,nil)
         == SQLITE_OK){
            sqlite3_bind_text(sqlite3_stmt, 1, id.cString(using: .utf8),-1,nil);
              if(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                lud = sqlite3_column_int64(sqlite3_stmt,1);
        
              }
          }
          sqlite3_finalize(sqlite3_stmt)
          return lud
     }
}

