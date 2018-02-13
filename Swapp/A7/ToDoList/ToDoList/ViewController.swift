//
//  ViewController.swift
//  ToDoList
//
//  Created by Ma, Jeffrey '18 on 2/13/18.
//  Copyright © 2018 Ma, Jeffrey '18. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var tasks : [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        //get the data from core data
        getData()
        //reload the table view
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        let task = tasks[indexPath.row]
        
        cell.textLabel?.text = task.name!
        
        return cell
        
    }
    
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
             tasks = try context.fetch(Task.fetchRequest())
        } catch {
            print("Fetching failed")
        }
       
    }
    
    
    
    

}

