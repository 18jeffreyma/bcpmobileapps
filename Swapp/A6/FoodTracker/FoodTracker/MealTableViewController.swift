//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Ma, Jeffrey '18 on 2/5/18.
//  Copyright © 2018 Ma, Jeffrey '18. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {

    var meals = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the sample data.
        loadSampleMeals()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //MARK: Actions
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
            
            // Add a new meal.
            let newIndexPath = IndexPath(row: meals.count, section: 0)
            
            meals.append(meal)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    //MARK: Private Methods
    
    private func loadSampleMeals() {
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        let photo4 = UIImage(named: "meal4")
        let photo5 = UIImage(named: "meal5")
        let photo6 = UIImage(named: "meal6")
        let photo7 = UIImage(named: "meal7")
       
        guard let meal1 = Meal(name: "Burger", photo: photo1, rating: 4) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let meal2 = Meal(name: "Cookies", photo: photo2, rating: 5) else {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let meal3 = Meal(name: "Italian", photo: photo3, rating: 3) else {
            fatalError("Unable to instantiate meal3")
        }
        
        guard let meal4 = Meal(name: "Hot Chocolate", photo: photo4, rating: 4) else {
            fatalError("Unable to instantiate meal4")
        }
        
        guard let meal5 = Meal(name: "Mongolian", photo: photo5, rating: 5) else {
            fatalError("Unable to instantiate meal5")
        }
        
        guard let meal6 = Meal(name: "Strawberry Shortcake", photo: photo6, rating: 3) else {
            fatalError("Unable to instantiate meal6")
        }
        
        guard let meal7 = Meal(name: "Thai", photo: photo7, rating: 3) else {
            fatalError("Unable to instantiate meal7")
        }
        
        meals += [meal1, meal2, meal3, meal4, meal5, meal6, meal7]
        
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView?.image = meal.photo
        cell.ratingControl.rating = meal.rating
        
        return cell
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
