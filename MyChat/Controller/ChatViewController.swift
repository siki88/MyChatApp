//
//  ChatViewController.swift
//  MyChat
//
//  Created by MPB on 01.03.18.
//  Copyright © 2018 MPB. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITextFieldDelegate {

    // MARK: data
    var me: User!
    
    var message = [Message]()
    
    // MARK: Outlets
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //print(me.name)
        self.title = me.name
        
        
        
       
    }
    
    // MARK: Functions
    
    @IBAction func sendMessage(_ sender: Any) {
        messageF()
    }
    
    func messageF(){
        if let message = txtMessage.text, !message.isEmpty  {
            print(message)
            txtMessage.text = nil
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtMessage.resignFirstResponder()
        return false
    }
    
    func testData(){
        let message1 = Message(text:"ahoj",sender:User(name:"Petr"))
        let message2 = Message(text:"nazdar",sender:User(name:"Pepa"))
        message = [message1, message2]
    }
    
    
    deinit {
        //vymazani objektu z paměti
        print("good bye")
    }


}
