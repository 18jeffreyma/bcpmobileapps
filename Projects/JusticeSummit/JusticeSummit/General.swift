//
//  General.swift
//  JusticeSummit
//
//  Created by Ma, Jeffrey '18 on 3/3/18.
//  Copyright © 2018 Ma, Jeffrey '18. All rights reserved.
//

import Foundation

public class General {
    public static var BASE_DIRECTORY = "http://times.bcp.org/webapps18/justiceSummit/"
    public static var LOGIN_URL = "login.php"
    public static var GET_USER_INFO_URL = "getUserInfo.php"
    public static var GET_CURRENT_SESSION_URL = "getCurrentSession.php"
    public static var ADD_SESSION_URL = "addSession.php"
    
    
    
    static func getCurrentSessionInfo(email: String, studentID: String, blockNumber: Int) -> [String: Any] {
        
        var currentSession: [String: Any] = ["test": "test"]
        
        let myGroup = DispatchGroup()
        
        myGroup.enter()
        
        getCurrentSessionPostRequest(email: email, studentID: studentID, blockNumber: blockNumber, completion: {(jsonDictionary) -> Void in
            
            currentSession = jsonDictionary
            
            myGroup.leave()

        })
        
        return currentSession
        
    }

        
    
    
    static func getCurrentSessionPostRequest(email: String, studentID: String, blockNumber: Int, completion: @escaping ([String: Any]) -> Void) {
        let url = URL(string: General.BASE_DIRECTORY + General.GET_CURRENT_SESSION_URL)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "email=" + email + "&studentID=" + studentID + "&blockNumber=" + String(blockNumber)
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
            
            completion(jsonDict)
            
        }
        task.resume()
        
        
    }
    
    
    
    static func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    static func getUserInfoPostRequest(email: String, studentID: String, completion: @escaping ([String]) -> Void) {
        let url = URL(string: General.BASE_DIRECTORY + General.GET_USER_INFO_URL)!
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
    
    static func loginPostRequest(email: String, studentID: String, completion: @escaping (Int) -> Void) {
        let url = URL(string: General.BASE_DIRECTORY + General.LOGIN_URL)!
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
    
}
