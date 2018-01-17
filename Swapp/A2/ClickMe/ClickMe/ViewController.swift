//
//  ViewController.swift
//  ClickMe
//
//  Created by Ma, Jeffrey '18 on 1/17/18.
//  Copyright © 2018 Ma, Jeffrey '18. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var theLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    
    
    
    var timer = Timer()
    
    var counter = 20
    var startCounter = 2
    
    var numberOfClicks = 0
    
    var timesUp = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theLabel.text = "Counter: 0"
        countdownLabel.text = "Ready? 3"
        // Do any additional setup after loading the view, typically from a nib.
        
        beginningTimer()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonClicked(_ sender: Any) {
        if (timesUp == false) {
            numberOfClicks += 1
            theLabel.text = "Counter: " + String(numberOfClicks)
        }
    }
    
    @IBAction func resetButtonClicked(_ sender: Any) {
        
        numberOfClicks = 0
        counter = 30
        startCounter = 2
        theLabel.text = "Counter: 0"
        countdownLabel.text = "Ready? 3"
        
        beginningTimer()
    
    }
    
    func startTimer( ) {
        // stop previous timer, if set
        timer.invalidate();
        
        // start new timer to run every second (1)
        // and to run method: timerAction
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
    }
    
    @objc func timerAction() {
        if( counter == 0 ) {
            timesUp = true
            countdownLabel.text = "Times Up!"
        } else {
            counter -= 1
            countdownLabel.text = String( counter )
        }
    }
    
    
    func beginningTimer( ) {
        
        timer.invalidate();
        
        // start new timer to run every second (1)
        //  and to run method: timerAction
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startAction), userInfo: nil, repeats: true)
    }
    
    @objc func startAction() {
        if( startCounter == 0 ) {
            timesUp = false
            countdownLabel.text = String(counter)
            startTimer()
            
        } else {
            countdownLabel.text = "Ready? " + String( startCounter )
            startCounter -= 1
            
        }
    }
    
    
}

