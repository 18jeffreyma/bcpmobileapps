//
//  ViewController.swift
//  Segue
//
//  Created by Ma, Jeffrey '18 on 1/29/18.
//  Copyright © 2018 Ma, Jeffrey '18. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var myWebView1: WKWebView!
    
    @IBOutlet weak var linkInputBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let url = URL( string: "https://www.google.com" )
        let httpRequest = URLRequest( url: url as! URL )
        myWebView1.load( httpRequest as URLRequest )
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if( segue.identifier == "sequeToPage2" ) {
            let secondViewController = segue.destination as! SecondSceneViewController
            secondViewController.link = linkInputBox.text
        }

    }


}

