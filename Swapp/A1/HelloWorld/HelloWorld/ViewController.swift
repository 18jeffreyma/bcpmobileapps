//
//  ViewController.swift
//  HelloWorld
//
//  Created by Ma, Jeffrey '18 on 1/16/18.
//  Copyright © 2018 Ma, Jeffrey '18. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var centeredText: UILabel!
    
    @IBOutlet weak var datetime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        centeredText.text = "ayy lmao"
        centeredText.font = UIFont(name: "Chalkduster", size: 50)
        centeredText.textColor = UIColor.blue
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        datetime.text = String(format: "%02d", hour) + ":" + String(format: "%02d", minutes)
        datetime.font = UIFont(name: "Chalkduster", size: 50)
        datetime.textColor = UIColor.red
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

