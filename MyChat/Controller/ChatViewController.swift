//
//  ChatViewController.swift
//  MyChat
//
//  Created by MPB on 01.03.18.
//  Copyright © 2018 MPB. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource {

    // MARK: data
    var me: User!
    
    var messages = [Message]()
    
    // MARK: Outlets
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //print(me.name)
        self.title = me.name
       
    testData()
       
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
        messages = [message1, message2]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: TableView
    

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
        let message = messages[indexPath.row]
        cell.lblName.text = message.sender.name
        cell.lblText.text = message.text
        return cell
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    
    deinit {
        //vymazani objektu z paměti
        print("good bye")
    }


}
