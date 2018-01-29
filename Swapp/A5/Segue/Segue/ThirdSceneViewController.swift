//
//  ThirdSceneViewController.swift
//  Segue
//
//  Created by Ma, Jeffrey '18 on 1/29/18.
//  Copyright © 2018 Ma, Jeffrey '18. All rights reserved.
//

import UIKit
import WebKit

class ThirdSceneViewController: UIViewController {

    @IBOutlet weak var myWebView3: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let url = URL( string: "https://www.bing.com" )
        let httpRequest = URLRequest( url: url as! URL )
        myWebView3.load( httpRequest as URLRequest )
        
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
