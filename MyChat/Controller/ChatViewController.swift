//
//  ChatViewController.swift
//  MyChat
//
//  Created by MPB on 01.03.18.
//  Copyright © 2018 MPB. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, DataManagerDelegate{

    // MARK: data
    var me: User!
  //  var messages = [Message]()
    var dataManager: DataManager! // volam class DataManager
    
    // MARK: Outlets
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomTableViewConsztraint: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataManager = DataManager()
        self.dataManager.delegate = self
        self.title = me.name
       
   // testData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: Notification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: Notification.Name.UIKeyboardWillShow, object: nil)
       
    }
    
    // MARK: Functions
    
    @IBAction func sendMessage() {
        if let text = txtMessage.text, !text.isEmpty  {
            let message = Message(text: text, sender: me)
            dataManager.sendMessage(message)
            txtMessage.text = nil
        }
    }
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtMessage.resignFirstResponder()
        return false
    }
 /*
    func testData(){
        let message1 = Message(text:"ahoj",sender:User(name:"Petr"))
        let message2 = Message(text:"nazdar",sender:User(name:"Pepa"))
        dataManager.messages = [message1, message2]
    }
 */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: TableView
    

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
        let message = dataManager.messages[indexPath.row]
        cell.lblName.text = message.sender.name
        cell.lblText.text = message.text
        return cell
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.messages.count
    }
    
    func dataManagerDidReceiveNewData(_ manager: DataManager) {
        tableView.reloadData()
    }
    

    
    @objc func keyboardWillAppear(_ notification: Notification) {
      
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            bottomTableViewConsztraint.constant = keyboardHeight
        }
    }
    
    @objc func keyboardWillDisappear() {
        bottomTableViewConsztraint.constant = 0
    }

    
    deinit {
        //vymazani objektu z paměti
        NotificationCenter.default.removeObserver(self)
        print("good bye")
    }


}
