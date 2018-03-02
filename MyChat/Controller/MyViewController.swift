//
//  MyViewController.swift
//  MyChat
//
//  Created by MPB on 02.03.18.
//  Copyright © 2018 MPB. All rights reserved.
//

import UIKit

class MyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    func printError(_ error: Error){
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle:UIAlertControllerStyle.alert)
             alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert,animated: true, completion: nil)
    }

}
