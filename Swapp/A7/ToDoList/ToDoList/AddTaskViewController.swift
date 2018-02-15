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
    
    @IBOutlet weak var prioritySlider: UISlider!
    
    @IBOutlet weak var priorityLabel: UILabel!
    
    @IBOutlet weak var addTaskButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTaskButton.isEnabled = false
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let task = Task(context: context)
        task.name = textField.text!
        task.priorityValue = Int16(prioritySlider.value)
        
        //Save the data to core data
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
    
    @IBAction func textfieldValueChanged(_ sender: Any) {
        if (textField.hasText) {
            addTaskButton.isEnabled = true
        } else {
            addTaskButton.isEnabled = false
        }
    }
    
    @IBAction func sliderChanged(_ sender: Any) {
        
        switch Int16(prioritySlider.value) {
        case 1:
            priorityLabel.text = "1 (Low)"
        case 2:
            priorityLabel.text = "2 (Medium-Low)"
        case 3:
            priorityLabel.text = "3 (Medium)"
        case 4:
            priorityLabel.text = "4 (Medium-High)"
        case 5:
            priorityLabel.text = "5 (High)"
        default:
            priorityLabel.text = "3 (Medium)"
        }
        
    }
    
}
