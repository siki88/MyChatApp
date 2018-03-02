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
    
    var dictionaryValue: NSDictionary{
        get{
            return ["text":text, "sender": ["name": sender.name]]
        }
    }
    
    init(text: String, sender: User){
        
        self.text = text
        self.sender = sender
    }
   
    init?(json: [String:Any]){
        if let messageText = json["text"] as? String,
        let senderJson = json["sender"] as? [String:Any],
            let sender = User(json: senderJson){
            self.text = messageText
            self.sender = sender
        }else{
            return nil
        }
    }
 
}
