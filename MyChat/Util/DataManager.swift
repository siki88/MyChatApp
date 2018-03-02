//
//  DataManager.swift
//  MyChat
//
//  Created by MPB on 02.03.18.
//  Copyright © 2018 MPB. All rights reserved.
//  DataManager propojuje komunikaci mezi chatviewcontroller a databazi

import Foundation
import FirebaseDatabase

protocol DataManagerDelegate:NSObjectProtocol{
    //definice funkce ktera bude posilat data zpět když dojde ke změně
    func dataManagerDidReceiveNewData(_ manager:DataManager)
}

class DataManager{
    
    weak var delegate: DataManagerDelegate?
    
    var messages = [Message]()
    
    init() {
      //  delegate?.dataManagerDidReceiveNewData(self)
        watchForUpdates()
        
    }
    
    //čekování databáze zda je tam změna
    func watchForUpdates(){  //tato funkce zůstává aktivní a kdykoliv se změní databáze tak se refrešne
        Database.database().reference(withPath:"Messages").observe(.value) {(snapshot) in
         //   print(snapshot.children.allObjects)
            
            //self.delegate?.dataManagerDidReceiveNewData(self)
            self.parseData(snapshot)
            
        }
    }
    
    func parseData(_ data: DataSnapshot){
        self.messages.removeAll() // smažu původní data
        
        for dictionary in data.children.allObjects{
           if let json = dictionary as? DataSnapshot,
            let messageJson = json.value as? [String:Any], //json.value osekne id a vypíše jsonMessage
            let messageText = messageJson["text"] as? String,
            let senderJson = messageJson["sender"] as? [String: Any],
            let senderName = senderJson["name"] as? String{
            
            let message = Message(text: messageText, sender: User(name: senderName))
            messages.append(message)
            
            
            }
        }
        
        
        messages.reverse() // otočení pole
        
        delegate?.dataManagerDidReceiveNewData(self)
    }
    
    //odesílání do databaze
    func sendMessage(_ message: Message){
      //  messages.insert(message, at: 0)
      //  delegate?.dataManagerDidReceiveNewData(self)
        let trigger = Database.database().reference(withPath:"Messages").childByAutoId()
        trigger.setValue(message.dictionaryValue)
    }
}
