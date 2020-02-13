//
//  ModelEvents.swift
//  Project
//
//  Created by admin on 14/01/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation


class ModelEvents{
    
    static let GroupDataEvent = EventNotificationBase(eventName: "GroupDataEvent");
    static let LoggingStateChangeEvent = EventNotificationBase(eventName: "LoggingStateChangeEvent");
    static let GPSUpdateEvent = EventNotificationBaseWithArgs<String>(eventName: "GPSUpdateEvent");
    
    
    private init(){
        //Cannot create instance.
    }
}
