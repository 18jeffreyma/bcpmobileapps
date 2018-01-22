//
//  ViewController.swift
//  SegQuotes
//
//  Created by Ma, Jeffrey '18 on 1/22/18.
//  Copyright © 2018 Ma, Jeffrey '18. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var theLabel: UILabel!
    
    @IBOutlet weak var quoteNumber: UILabel!
    
    @IBOutlet weak var personSelection: UISegmentedControl!
    @IBOutlet weak var quoteNumberSelection: UISlider!
    
    
    
    
    let einsteinQuotes: [String] = ["There are only two ways to live your life. One is as though nothing is a miracle. The other is as though everything is a miracle.", "We still do not know one-thousandth of one percent of what nature has revealed to us.", "He who can no longer pause to wonder and stand rapt in awe, is as good as dead his eyes are closed.", "It is the theory that decides what we can observe.", "We should take care not to make the intellect our god it has, of course, powerful muscles, but no personality."]
    let ghandiQuotes: [String] = ["Happiness is when what you think, what you say, and what you do are in harmony.", "Where there is love there is life.", "Strength does not come from physical capacity. It comes from an indomitable will.", "The future depends on what we do in the present.", "Action expresses priorities."]
    let seussQuotes: [String] = ["Be who you are and say what you feel, because those who mind don't matter and those who matter don't mind.", "The more that you read, the more things you will know. The more that you learn, the more places you'll go.", "Don't cry because it's over. Smile because it happened.", "Today you are you! That is truer than true! There is no one alive who is you-er than you!", "Unless someone like you cares a whole awful lot, nothing is going to get better. It's not."]
    
    let colors: [UIColor] = [UIColor.black, UIColor.blue, UIColor.red, UIColor.brown, UIColor.green]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func segmentSelected(_ sender: UISegmentedControl) {
        
        theLabel.textColor = colors[Int(quoteNumberSelection.value)]
        
        switch sender.selectedSegmentIndex {
            case 0:
                theLabel.text = "\"" + einsteinQuotes[Int(quoteNumberSelection.value)] + "\""
            case 1:
                theLabel.text = "\"" + ghandiQuotes[Int(quoteNumberSelection.value)] + "\""
            case 2:
                theLabel.text = "\"" + seussQuotes[Int(quoteNumberSelection.value)] + "\""
            default:
                theLabel.text = "Choose a person!"
        }
    }
    
    @IBAction func slideValueChanged(_ sender: UISlider) {
        
        quoteNumber.text = String(Int(sender.value) + 1)
        
        theLabel.textColor = colors[Int(sender.value)]
        
        switch personSelection.selectedSegmentIndex {
            case 0:
                theLabel.text = "\"" + einsteinQuotes[Int(sender.value)] + "\""
            case 1:
                theLabel.text = "\"" + ghandiQuotes[Int(sender.value)] + "\""
            case 2:
                theLabel.text = "\"" + seussQuotes[Int(sender.value)] + "\""
            default:
                theLabel.text = "Choose a person!"
            }
        
    }
}

