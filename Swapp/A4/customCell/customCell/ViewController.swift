//
//  ViewController.swift
//  customCell
//
//  Created by Ma, Jeffrey '18 on 1/24/18.
//  Copyright © 2018 Ma, Jeffrey '18. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (list.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        cell.myImage.image = UIImage(named: list[indexPath.row] + ".jpg")
        cell.myLabel.text = list[indexPath.row]
        
        return (cell)
    }
    
    
    let list = ["Brad Lindemann", "Jeffrey Ma", "Will Portman", "Alexander Knappen", "Joshua Holden", "Phillip Si"]
    
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

