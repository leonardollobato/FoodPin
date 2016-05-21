//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Leonardo Lobato on 5/16/16.
//  Copyright © 2016 Leonardo Lobato. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var restaurantImageView:UIImageView!
    @IBOutlet var tableView:UITableView!
    @IBOutlet var ratingButton:UIButton!
    
    var restaurant:Restaurant!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        restaurantImageView.image = UIImage(named: restaurant.image)
        title = restaurant.name

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RestaurantDetailTableViewCell
        
        switch indexPath.row {
            case 0:
                cell.fieldLabel.text = "Name"
                cell.valueLabel.text = restaurant.name
            case 1:
                cell.fieldLabel.text = "Type"
                cell.valueLabel.text = restaurant.type
            case 2:
                cell.fieldLabel.text = "Location"
                cell.valueLabel.text = restaurant.location
            case 3:
                cell.fieldLabel.text = "Been Here"
                cell.valueLabel.text = (restaurant.isVisited) ? "Yes, I've Been here" : "No"
            case 4:
                cell.fieldLabel.text = "Phone"
                cell.valueLabel.text = restaurant.phoneNumber
            default:
                cell.fieldLabel.text = ""
                cell.valueLabel.text = ""
        }
        
        return cell;
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showReview" {
            let destinationVC = segue.destinationViewController as! ReviewViewController
            destinationVC.bgImage = (restaurant.image != "" ? restaurant.image : "barrafina")
        }
        
        if segue.identifier == "showMap" {
            let destinationVC = segue.destinationViewController as! MapViewController
            destinationVC.restaurant = restaurant
        }
    }
    
    @IBAction func close(segue:UIStoryboardSegue){
        if let ReviewViewController = segue.sourceViewController as? ReviewViewController {
            if let rating = ReviewViewController.rating {
                ratingButton.setImage(UIImage(named:rating), forState: UIControlState.Normal)
                restaurant.rating = rating
            }
        }
    }

}
