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
        
        switch task.priorityValue {
        case 1:
            cell.backgroundColor = UIColor(red:1.00, green:0.55, blue:0.58, alpha:1.0)
            
        case 2:
            cell.backgroundColor = UIColor(red:1.00, green:0.83, blue:0.71, alpha:1.0)
            
        case 3:
            cell.backgroundColor = UIColor(red:0.99, green:0.99, blue:0.59, alpha:1.0)
            
        case 4:
            cell.backgroundColor = UIColor(red:0.86, green:0.93, blue:0.76, alpha:1.0)
            
        case 5:
            cell.backgroundColor = UIColor(red:0.66, green:0.90, blue:0.81, alpha:1.0)
            
        default:
            cell.backgroundColor = UIColor(red:0.75, green:0.87, blue:0.85, alpha:1.0)
        }
        

        return cell
        
    }
    
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
             tasks = try context.fetch(Task.fetchRequest())
        } catch {
            print("Fetching failed")
        }
        
        tasks.sort(by: {$0.name! < $1.name!})
        tasks.sort(by: {$0.priorityValue < $1.priorityValue})
        
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            
            do {
                tasks = try context.fetch(Task.fetchRequest())
            } catch {
                print("Fetching failed")
            }
        
            
        
        }
        tableView.reloadData()      
        
    }
    
    
    
    

}

