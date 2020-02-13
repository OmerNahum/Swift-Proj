//
//  GroupWithSqlLite.swift
//  Project
//
//  Created by admin on 21/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation


extension Group{
static func create_table(database: OpaquePointer?){
    var errormsg: UnsafeMutablePointer<Int8>? = nil
    let res = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS GROUPS (GROUP_ID TEXT PRIMARY KEY, NAME TEXT, IMAGE TEXT)", nil, nil, &errormsg);
    if(res != 0){
        print("error creating table");
        return
    }
}

func addToDb(){
    var sqlite3_stmt: OpaquePointer? = nil
    if (sqlite3_prepare_v2(ModelSql.instance.database,"INSERT OR REPLACE INTO STUDENTS(ST_ID, NAME, AVATAR) VALUES (?,?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
        let id = self.id.cString(using: .utf8)
        let name = self.name.cString(using: .utf8)
        let avatar = self.avatar.cString(using: .utf8)
        
        sqlite3_bind_text(sqlite3_stmt, 1, id,-1,nil);
        sqlite3_bind_text(sqlite3_stmt, 2, name,-1,nil);
        sqlite3_bind_text(sqlite3_stmt, 3, avatar,-1,nil);
        if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
            print("new row added succefully")
        }
    }
    sqlite3_finalize(sqlite3_stmt)
}

static func getAllStudentsFromDb()->[Student]{
    var sqlite3_stmt: OpaquePointer? = nil
    var data = [Student]()
    
    if (sqlite3_prepare_v2(ModelSql.instance.database,"SELECT * from STUDENTS;",-1,&sqlite3_stmt,nil)
        == SQLITE_OK){
        while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
            let stId = String(cString:sqlite3_column_text(sqlite3_stmt,0)!)
            let st = Student(id: stId);
            st.name = String(cString:sqlite3_column_text(sqlite3_stmt,1)!)
            st.avatar = String(cString:sqlite3_column_text(sqlite3_stmt,2)!)
            data.append(st)
        }
    }
    sqlite3_finalize(sqlite3_stmt)
    return data
}

static func setLastUpdate(lastUpdated:Int64){
    return ModelSql.instance.setLastUpdate(name: "STUDENTS", lastUpdated: lastUpdated);
}

static func getLastUpdateDate()->Int64{
    return ModelSql.instance.getLastUpdateDate(name: "STUDENTS")
}
