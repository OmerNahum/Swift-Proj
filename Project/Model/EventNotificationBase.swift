//
//  EventNotificationBase.swift
//  Project
//
//  Created by admin on 14/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation


class EventNotificationBase{
    let eventName:String;
    
    init(eventName: String){
        self.eventName = eventName;
    }
    
    func observe(callback: @escaping () -> Void){
        NotificationCenter.default.addObserver(forName: NSNotification.Name(eventName),
                                               object: nil, queue: nil) { (data) in
                                                callback();
        }
    }
    
    
    func post(){
        NotificationCenter.default.post(name: NSNotification.Name(eventName),
                                        object: self,
                                        userInfo: nil);
    }
}

class EventNotificationBaseWithArgs<T>{
    let eventName:String;
    
    init(eventName: String){
        self.eventName = eventName;
    }
    
    func observe(callback: @escaping (T) -> Void){
        NotificationCenter.default.addObserver(forName: NSNotification.Name(eventName),
                                               object: nil, queue: nil) { (data) in
                                                let d: T = data.userInfo!["data"] as! T;
                                                callback(d);
        }
    }
    
    
    func post(data:T){
        NotificationCenter.default.post(name: NSNotification.Name(eventName),
                                        object: self,
                                        userInfo: ["data": data]);
    }
}
