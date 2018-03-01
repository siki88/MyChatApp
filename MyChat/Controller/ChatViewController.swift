//
//  ChatViewController.swift
//  MyChat
//
//  Created by MPB on 01.03.18.
//  Copyright © 2018 MPB. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    // MARK: DATA
    
    var me: User!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    //print(me.name)
        self.title = me.name
       
    }


}
