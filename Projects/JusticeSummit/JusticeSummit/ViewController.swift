//
//  ViewController.swift
//  JusticeSummit
//
//  Created by Ma, Jeffrey '18 on 2/27/18.
//  Copyright © 2018 Ma, Jeffrey '18. All rights reserved.
//

import UIKit
import SQLite3

class ViewController: UIViewController {

    

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var studentIDTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loginButton.alpha = 0.5
        loginButton.isEnabled = false
        
        
        emailTextField.addTarget(self, action: #selector(emailChanged(_:)), for: .editingChanged)
        
        studentIDTextField.addTarget(self, action: #selector(studentIDChanged(_:)), for: .editingChanged)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
   
    @IBAction func emailChanged(_ sender: UITextField) {
        if (checkIfAllFilled()) {
            loginButton.alpha = 1
            loginButton.isEnabled = true
        } else {
            loginButton.alpha = 0.5
            loginButton.isEnabled = false
        }
    }
    
    @IBAction func studentIDChanged(_ sender: UITextField) {
        
        let text = studentIDTextField.text
        
        if (text!.count > 6) {
            studentIDTextField.text?.remove(at: (studentIDTextField.text?.index(before: (studentIDTextField.text?.endIndex)!))!)
        }
        
        
        if (checkIfAllFilled()) {
            loginButton.alpha = 1
            loginButton.isEnabled = true
        } else {
            loginButton.alpha = 0.5
            loginButton.isEnabled = false
        }
    }
    
    func checkIfAllFilled() -> Bool {
        return (emailTextField.hasText && studentIDTextField.text?.count == 6)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        // TODO check if student in database
    }
    
}

