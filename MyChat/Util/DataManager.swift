//
//  DataManager.swift
//  MyChat
//
//  Created by MPB on 02.03.18.
//  Copyright © 2018 MPB. All rights reserved.
//  DataManager propojuje komunikaci mezi chatviewcontroller a databazi

import Foundation

protocol DataManagerDelegate:NSObjectProtocol{
    //definice funkce ktera bude posilat data zpět když dojde ke změně
    func dataManagerDidReceiveNewData(_ manager:DataManager)
}

class DataManager{
    
    weak var delegate: DataManagerDelegate?
    
    var messages = [Message]()
    
    init() {
      //  delegate?.dataManagerDidReceiveNewData(self)
        
    }
    

    
    func sendMessage(_ message: Message){
        messages.insert(message, at: 0)
        delegate?.dataManagerDidReceiveNewData(self)
    }

    
}
