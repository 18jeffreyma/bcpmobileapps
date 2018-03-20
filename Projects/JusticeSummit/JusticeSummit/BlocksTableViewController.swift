//
//  BlocksTableViewController.swift
//  JusticeSummit
//
//  Created by Ma, Jeffrey '18 on 3/3/18.
//  Copyright © 2018 Ma, Jeffrey '18. All rights reserved.
//

import UIKit

class BlocksTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    
    @IBOutlet weak var greeting: UILabel!
    
    
    let sessions = [1,2,3]
    var sessionTitles: [String] = []
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        let prefs = UserDefaults.standard
        let email = prefs.string(forKey: "email")!
        let studentID = prefs.string(forKey: "studentID")!
        let firstName = prefs.string(forKey: "firstName")!
        let lastName = prefs.string(forKey: "lastName")!
        let grade = prefs.string(forKey: "grade")!
        
        // figure out how to load data
        
        greeting.text = "Hello, " + firstName + " " + lastName + "!"
        
        
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
        
        let prefs = UserDefaults.standard
        
        cell.sessionBlockTitle?.text = "Session Block " + String(sessions[indexPath.row])
        
        General.getCurrentSessionPostRequest(email: prefs.string(forKey: "email")!, studentID: prefs.string(forKey: "studentID")!, blockNumber: (indexPath.row+1), completion: {(jsonDictionary) -> Void in
            
            
                DispatchQueue.main.async {
                    cell.selectedSessionTitle?.text = jsonDictionary["title"] as! String
            
                    if (jsonDictionary["title"] == nil) {
                        cell.completedImageView.image = UIImage(named: "incomplete")
                    } else {
                        cell.completedImageView.image = UIImage(named: "complete")
                    }
                    
                    
                }
            
            
        })
        
        
        
        
        
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
    
    func loadSelected(email: String, studentID: String) {
        for block in sessions {
            
            print(General.getCurrentSessionInfo(email: email, studentID: studentID, blockNumber: block)["title"])
            
            
            // sessionTitles[block] = General.getCurrentSessionInfo(email: email, studentID: studentID, blockNumber: block)["title"] as! String
        }
    }

    @IBAction func logout(_ sender: UIBarButtonItem) {
        let defaults = UserDefaults.standard
        
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        
        self.performSegue(withIdentifier: "logout", sender: nil)
    
    }
}
