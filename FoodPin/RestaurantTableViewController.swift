//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Leonardo Lobato on 5/12/16.
//  Copyright © 2016 Leonardo Lobato. All rights reserved.
//

import UIKit


class RestaurantTableViewController: UITableViewController {
    
    var restaurants:[Restaurant] = [
            Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "Hong Kong", image: "cafedeadend.jpg", isVisited: false, phoneNumber: "82828-3234"),
            Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image: "homei.jpg", isVisited: false, phoneNumber: "82828-3234"),
            Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image:"teakha.jpg", isVisited: false, phoneNumber: "82828-3234"),
            Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location:"Hong Kong", image: "cafeloisl.jpg", isVisited: false, phoneNumber: "82828-3234"),
            Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong", image: "petiteoyster.jpg", isVisited: false, phoneNumber: "82828-3234"),
            Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", image: "forkeerestaurant.jpg", isVisited: false, phoneNumber: "82828-3234"),
            Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong",image: "posatelier.jpg", isVisited: false, phoneNumber: "82828-3234"),
            Restaurant(name: "Bourke Street Backery", type: "Chocolate", location:"Sydney", image: "bourkestreetbakery.jpg", isVisited: false, phoneNumber: "82828-3234"),
            Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", image: "haighschocolate.jpg", isVisited: false, phoneNumber: "82828-3234"),
            Restaurant(name: "Palomino Espresso", type: "American / Seafood", location:"Sydney", image: "palominoespresso.jpg", isVisited: false, phoneNumber: "82828-3234"),
            Restaurant(name: "Upstate", type: "American", location: "New York", image: "upstate.jpg", isVisited: false, phoneNumber: "82828-3234"),
            Restaurant(name: "Traif", type: "American", location: "New York", image:"traif.jpg", isVisited: false, phoneNumber: "82828-3234"),
            Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "grahamavenuemeats.jpg", isVisited: false, phoneNumber: "82828-3234"),
            Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York", image: "wafflewolf.jpg", isVisited: false, phoneNumber: "82828-3234"),
            Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York",image: "fiveleaves.jpg", isVisited: false, phoneNumber: "82828-3234"),
            Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", image: "cafelore.jpg", isVisited: false, phoneNumber: "82828-3234"),
            Restaurant(name: "Confessional", type: "Spanish", location: "New York",image: "confessional.jpg", isVisited: false, phoneNumber: "82828-3234"),
            Restaurant(name: "Barrafina", type: "Spanish", location: "London", image:"barrafina.jpg", isVisited: false, phoneNumber: "82828-3234"),
            Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "donostia.jpg", isVisited: false, phoneNumber: "82828-3234"),
            Restaurant(name: "Royal Oak", type: "British", location: "London", image: "royaloak.jpg", isVisited: false, phoneNumber: "82828-3234"),
            Restaurant(name: "Thai Cafe", type: "Thai", location: "London", image:"thaicafe.jpg", isVisited: false, phoneNumber: "82828-3234")
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action:nil)
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RestaurantTableViewCell
        
        cell.nameLabel.text = restaurants[indexPath.row].name
        cell.thumbnailImageView.image = UIImage(named: restaurants[indexPath.row].image)
        cell.thumbnailImageView.layer.cornerRadius = 30.0
        cell.thumbnailImageView.clipsToBounds = true
        cell.typeLabel.text = restaurants[indexPath.row].type
        cell.locationLabel.text = restaurants[indexPath.row].location
        
        if restaurants[indexPath.row].isVisited {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        
        return cell
    }
    

    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {

        let shareAction = UITableViewRowAction(style:UITableViewRowActionStyle.Default, title: "Share", handler: { (action,
                indexPath) -> Void in
                let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name
                if let imageToShare = UIImage(named:self.restaurants[indexPath.row].image) {
                    let activityController = UIActivityViewController(activityItems:[defaultText, imageToShare],applicationActivities: nil)
                    self.presentViewController(activityController, animated: true,
                        completion: nil)
                } })
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete") { (action, indexPath) in
            self.restaurants.removeAtIndex(indexPath.row)

            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        
        shareAction.backgroundColor = UIColor(red: 28.0/255.0, green: 165.0/255.0,blue: 253.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        return [deleteAction, shareAction]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destinationViewController as! RestaurantDetailViewController
                destinationController.restaurant = restaurants[indexPath.row]
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
    }
}
