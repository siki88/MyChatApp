//
//  DataManager.swift
//  MyChat
//
//  Created by MPB on 02.03.18.
//  Copyright © 2018 MPB.  } rights reserved.
//  DataManager propojuje komunikaci mezi chatviewcontroller a databazi

import Foundation
import FirebaseDatabase
import Alamofire

protocol DataManagerDelegate:NSObjectProtocol{
    //definice funkce ktera bude posilat data zpět když dojde ke změně
    func dataManagerDidReceiveNewData(_ manager:DataManager)
    func dataManagerDidFailWithError(_ error: Error)
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
            let messageJson = json.value as? [String:Any],
            let message = Message(json: messageJson){

            messages.append(message)
            
            
            
            }
        }
        
        
        messages.reverse() // otočení pole
        
        delegate?.dataManagerDidReceiveNewData(self)
    }
    
    //odesílání do databaze
    func sendMessage(_ message: Message){

        let trigger = Database.database().reference(withPath:"Messages").childByAutoId()
        trigger.setValue(message.dictionaryValue)
    }
    
    // MARK : - API Request
    
    
    func getDataFromAPI(){
        let urlString = URL(string:"http://private-6c237c-testchatapp.apiary-mock.com/messages")!
       // let parameters: Parameters = ["foo": "bar"]
        
        

        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                
                
                
                switch response.result{
                case .success(let json):
                    
                    if let validJson = json as? [[String:AnyObject]]{
                        for item in validJson{
                            if let message = Message(json: item){
                                self.messages.append(message)
                            
                            }
                        }
                    }
                self.delegate?.dataManagerDidReceiveNewData(self)
                self.watchForUpdates()
                    
                case .failure(let error):
                    self.delegate?.dataManagerDidFailWithError(error)
                   // print(error)
                    
                    
                }
          }
    
    }
}
