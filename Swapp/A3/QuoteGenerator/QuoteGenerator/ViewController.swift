//
//  ViewController.swift
//  QuoteGenerator
//
//  Created by Ma, Jeffrey '18 on 1/18/18.
//  Copyright © 2018 Ma, Jeffrey '18. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var theLabel: UILabel!
    
    
    let einsteinQuotes: [String] = ["There are only two ways to live your life. One is as though nothing is a miracle. The other is as though everything is a miracle.", "We still do not know one-thousandth of one percent of what nature has revealed to us.", "He who can no longer pause to wonder and stand rapt in awe, is as good as dead his eyes are closed.", "It is the theory that decides what we can observe.", "We should take care not to make the intellect our god it has, of course, powerful muscles, but no personality."]
    let ghandiQuotes: [String] = ["Happiness is when what you think, what you say, and what you do are in harmony.", "Where there is love there is life.", "Strength does not come from physical capacity. It comes from an indomitable will.", "The future depends on what we do in the present.", "Action expresses priorities."]
    let seussQuotes: [String] = ["Be who you are and say what you feel, because those who mind don't matter and those who matter don't mind.", "The more that you read, the more things you will know. The more that you learn, the more places you'll go.", "Don't cry because it's over. Smile because it happened.", "Today you are you! That is truer than true! There is no one alive who is you-er than you!", "Unless someone like you cares a whole awful lot, nothing is going to get better. It's not."]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.yellow

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func einsteinClicked(_ sender: Any) {
        einstreinFunction()
    }
    
    func einstreinFunction() {
        let diceRoll = Int(arc4random_uniform(UInt32(einsteinQuotes.count)))
        if (theLabel.text == einsteinQuotes[diceRoll]) {
            einstreinFunction()
        } else {
            theLabel.text = "\"" + einsteinQuotes[diceRoll] + "\""
        }
    }
    
    @IBAction func ghandiClicked(_ sender: Any) {
        ghandiFunction()
    }
    
    func ghandiFunction() {
        let diceRoll = Int(arc4random_uniform(UInt32(ghandiQuotes.count)))
        if (theLabel.text == ghandiQuotes[diceRoll]) {
            ghandiFunction()
        } else {
            theLabel.text = "\"" + ghandiQuotes[diceRoll] + "\""
        }
    }
    
    @IBAction func seussClicked(_ sender: Any) {
        seussFunction()
    }
    
    func seussFunction() {
        let diceRoll = Int(arc4random_uniform(UInt32(seussQuotes.count)))
        if (theLabel.text == seussQuotes[diceRoll]) {
            seussFunction()
        } else {
            theLabel.text = "\"" + seussQuotes[diceRoll] + "\""
        }
    }
    
}

