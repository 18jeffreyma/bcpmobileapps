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
    public static var GET_SELECTED_SESSION_URL = "getCurrentSession.php"
    public static var GET_ALL_SESSIONS_URL = "getSessions.php"
    public static var ADD_SESSION_URL = "addSession.php"
    public static var GET_SESSION_TITLE_URL = "getSessionTitle.php"
    public static var GET_FULL_SESSION_INFO_URL = "getSessionFullInformation.php"
    
    static func getSessionTitle(sessionID: String, completion: @escaping (String) -> Void) {
        if sessionID == "null" {
            completion("None")
        }
        
        let url = URL(string: General.BASE_DIRECTORY + General.GET_SESSION_TITLE_URL)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "sessionID=" + sessionID
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
            
            
            let userInfo: String = jsonDict["title"]! as! String
            
            completion(userInfo)
            
        }
    }
    
    
    static func getSelectedSessionID(email: String, studentID: String, blockNumber: Int, completion: @escaping (String) -> Void) {
        let url = URL(string: General.BASE_DIRECTORY + General.GET_SELECTED_SESSION_URL)!
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
            
            if let userInfo = (jsonDict["sessionID"] as? String) {
    
                General.getSessionTitle(sessionID: userInfo, completion: {(sessionTitle) -> Void in
                    
                    completion(sessionTitle)
                    
                })
            } else {
                completion("None")
            }
            
            
            
           
            
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
