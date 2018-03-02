//
//  User.swift
//  MyChat Dev
//
//  Created by MPB on 01.03.18.
//  Copyright © 2018 MPB. All rights reserved.
//

import Foundation

class User {
    
    let name:String
    
    init(name:String){
        self.name = name
    }
    
    
    init?(json: [String:Any]){
        if let senderName = json["name"] as? String {
            self.name = senderName
            
        }else{
            return nil
        }
    }
    
    
}
