//
//  SecondSceneViewController.swift
//  Segue
//
//  Created by Ma, Jeffrey '18 on 1/29/18.
//  Copyright © 2018 Ma, Jeffrey '18. All rights reserved.
//

import UIKit
import WebKit

class SecondSceneViewController: UIViewController {

    @IBOutlet weak var myWebView2: WKWebView!
    @IBOutlet weak var myLabel: UILabel!
    var labelText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let url = URL( string: "https://ddg.gg" )
        let httpRequest = URLRequest( url: url as! URL )
        myWebView2.load( httpRequest as URLRequest )
        
        // Optional passed data
        myLabel.text = labelText
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
