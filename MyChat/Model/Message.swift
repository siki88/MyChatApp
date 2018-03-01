//
//  Message.swift
//  MyChat
//
//  Created by MPB on 01.03.18.
//  Copyright © 2018 MPB. All rights reserved.
//

import Foundation

class Message{
    
    let text:String
    let sender: User
    
    init(text: String, sender: User){
        
        self.text = text
        self.sender = sender
    }
    
}
