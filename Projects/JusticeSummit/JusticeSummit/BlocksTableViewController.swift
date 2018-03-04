//
//  BlocksTableViewController.swift
//  JusticeSummit
//
//  Created by Ma, Jeffrey '18 on 3/3/18.
//  Copyright © 2018 Ma, Jeffrey '18. All rights reserved.
//

import UIKit

class BlocksTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    

    
    let sessions = [1,2,3,4]
    var sessionTitles: [String] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()

        let prefs = UserDefaults.standard
        let email = prefs.string(forKey: "email")!
        let studentID = prefs.string(forKey: "studentID")!
        let firstName = prefs.string(forKey: "firstName")!
        let lastName = prefs.string(forKey: "lastName")!
        let grade = prefs.string(forKey: "grade")!
        

        // TODO FIGURE OUT HOW TO GET CURRENT SESSIONS EASILY
        
        /*
        General.loginPostRequest(email: email, studentID: studentID, completion: { (loginStatus) -> Void in
            
            let isLoggedIn = loginStatus
            
            // what the structure looks like
            
            
        })
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "blockCell", for: indexPath) as! BlocksTableViewCell
        
        cell.sessionBlockTitle?.text = "Session Block " + String(sessions[indexPath.row])
        cell.selectedSessionTitle?.text = sessionTitles[indexPath.row]
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
