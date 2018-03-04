//
//  ViewController.swift
//  JusticeSummit
//
//  Created by Ma, Jeffrey '18 on 2/27/18.
//  Copyright © 2018 Ma, Jeffrey '18. All rights reserved.
//

import UIKit
import SQLite3

class LoginViewController: UIViewController {

    

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
        
        
        
        // TODO check if user data is stored in prefs already
        
        if (UserDefaults.standard.object(forKey: "loggedIn") != nil) {
            // if already logged in, segue to the next one
            
        }
        
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
        
        var isLoggedIn = 0
        
        let email = emailTextField.text!
        let studentID = studentIDTextField.text!
       
        
        General.loginPostRequest(email: email, studentID: studentID, completion: { (loginStatus) -> Void in
            
            isLoggedIn = loginStatus
            
            
            if (isLoggedIn == 1){
                print("Logged In")
                
                // TODO add credentials to prefs
                
                let prefs = UserDefaults.standard
                prefs.set("true", forKey: "loggedIn")
                prefs.set(email, forKey: "email")
                prefs.set(studentID, forKey: "studentID")
                
                General.getUserInfoPostRequest(email: email, studentID: studentID, completion: { (userInfo) -> Void in
                    
                    
                    prefs.set(userInfo[0], forKey: "firstName")
                    prefs.set(userInfo[1], forKey: "lastName")
                    prefs.set(userInfo[2], forKey: "grade")
                    
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "loginToMain", sender: nil)
                    }
                })
                
                
                    
                    
                    
            
                
                // TODO segue to a tableview
                
                
            } else {
                print("Wrong Login")
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Incorrect Credentials", message: "Email and Student ID do not match. Try again.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            
            }

        })
    }
}
