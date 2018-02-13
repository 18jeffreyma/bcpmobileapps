//
//  AddTaskViewController.swift
//  ToDoList
//
//  Created by Ma, Jeffrey '18 on 2/13/18.
//  Copyright © 2018 Ma, Jeffrey '18. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var isImp: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let task = Task(context: context)
        task.name = textField.text!
        task.isImportant = isImp.isOn
        
        //Save the data to core data
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
    

}
