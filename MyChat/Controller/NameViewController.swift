//
//  NameViewController.swift
//  MyChat
//
//  Created by MPB on 01.03.18.
//  Copyright © 2018 MPB. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var hello: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnStart: UIButton!
    
    // MARK: - Init     toto se spusti okamzite
    override func viewDidLoad() {
        super.viewDidLoad()

     vzhled()
     loadMyName()
     checkInput()
        

  
    }
    
    // MARK: VZHLED
    func vzhled(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    // toto se spusti az pri zobrazovani obrazovky
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print("zobrazeno")
    }

    
    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   */
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // MARK: - Function

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { //tato funkce se zavolá kdyz se posouváme jinam
        super.prepare(for: segue, sender: sender)
        
        txtName.resignFirstResponder() //schovám klávesnici
        
        if let destination = segue.destination as? ChatViewController, let userName = txtName.text {
            let user = User(name:userName)
            destination.me = user
            saveMyName(userName)
        }
    }
    
    @IBAction func akceKlavesnice(){
        checkInput()
    }
    
    func checkInput() {
        
        if let text = txtName.text, text.count > 2  {
            btnStart.isUserInteractionEnabled = true
        }else{
            btnStart.isUserInteractionEnabled = false
        }
    }
    
    //MARK : storage - ulozeni dat do aplikace
    
    let userNameConstant = "MyName"
    
    func loadMyName(){ // ulozeni mého jmena
        if let myName = UserDefaults.standard.object(forKey: userNameConstant) as? String {
            txtName.text = myName
        }
    }
    
    func saveMyName(_ name: String){ // ulozeni mého jmena
            UserDefaults.standard.set(name, forKey: "MyName")
    }
    

}

