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
        
        var isLoggedIn: Int = 0
        
        loginPostRequest(email: emailTextField.text!, studentID: studentIDTextField.text!) {
            
            loginStatus in
            isLoggedIn = loginStatus
            
            // print("\(isLoggedIn)")
            
            if (isLoggedIn == 1){
                print("Logged In")
                
                // TODO add credentials to datamodel
                
                
            } else {
                print("Wrong Login")
                
                // TODO fix this error which leads to sigabart
                
                /*
                let alert = UIAlertController(title: "Incorrect Credentials", message: "Email and Student ID do not match. Try again.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                */
            }
            
        }
        
        
        
    }
    
    func loginPostRequest(email: String, studentID: String, completionHandler: @escaping (_ loginStatus: Int) -> ()) {
        let url = URL(string: Links.LOGIN_URL)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "email=" + email + "&studentID=" + studentID
        request.httpBody = postString.data(using: .utf8)
        
        var jsonDict = Dictionary<String, Any>()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
        
                return
                
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                
                
                
            }
            
            let responseString = String(data: data, encoding: .utf8)
            
            //print("responseString = \(responseString)")
            
            jsonDict = self.convertToDictionary(text: responseString!)!
        
            //print("loggedIn = \(jsonDict["loggedIn"]!)")
            
            completionHandler(jsonDict["loggedIn"]! as! Int)
            
        }
        task.resume()
        
        
    }
    
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}


