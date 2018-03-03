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
        
        // TODO check if user data is stored in prefs already
        
        
        
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
    
    func loginPostRequest(email: String, studentID: String, completion: @escaping (Int) -> Void) {
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
            
            completion(jsonDict["loggedIn"]! as! Int)
            
        }
        task.resume()
        
        
    }
    
    func getUserInfoPostRequest(email: String, studentID: String, completion: @escaping ([String]) -> Void) {
        let url = URL(string: Links.GET_USER_INFO_URL)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "email=" + email + "&studentID=" + studentID
        request.httpBody = postString.data(using: .utf8)
        
       
        
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
            
            let jsonDict = self.convertToDictionary(text: responseString!)!
            
            //print("loggedIn = \(jsonDict["loggedIn"]!)")
          
            
            let userInfo: [String] = [jsonDict["firstName"]! as! String,jsonDict["lastName"]! as! String,jsonDict["grade"]! as! String]

            completion(userInfo)
            
        }
        task.resume()
        
        
    }
    
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        // TODO check if student in database
        
        var isLoggedIn = 0
        
        let email = emailTextField.text!
        let studentID = studentIDTextField.text!
       
        
        loginPostRequest(email: email, studentID: studentID, completion: { (loginStatus) -> Void in
            
            isLoggedIn = loginStatus
            
            
            if (isLoggedIn == 1){
                print("Logged In")
                
                // TODO add credentials to prefs
                
                let prefs = UserDefaults.standard
                prefs.set(email, forKey: "email")
                prefs.set(studentID, forKey: "studentID")
                
                self.getUserInfoPostRequest(email: email, studentID: studentID, completion: { (userInfo) -> Void in
                    
                    
                    prefs.set(userInfo[0], forKey: "firstName")
                    prefs.set(userInfo[1], forKey: "lastName")
                    prefs.set(userInfo[2], forKey: "grade")
                    
                    
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
