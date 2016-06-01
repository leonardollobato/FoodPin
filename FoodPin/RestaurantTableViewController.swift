//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Leonardo Lobato on 5/12/16.
//  Copyright © 2016 Leonardo Lobato. All rights reserved.
//

import UIKit
import CoreData


class RestaurantTableViewController: UITableViewController,
                                NSFetchedResultsControllerDelegate,
UISearchResultsUpdating{
    
    var restaurants:[Restaurant] = []
    var fetchResultController:NSFetchedResultsController!
    var searchController:UISearchController!
    var searchResults:[Restaurant] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action:nil)
        
        let fetchRequest = NSFetchRequest(entityName: "Restaurant")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let sortDescriptorTwo = NSSortDescriptor(key: "location", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor, sortDescriptorTwo]
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext{
            self.fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do{
                try fetchResultController.performFetch()
                restaurants = fetchResultController.fetchedObjects as! [Restaurant]
            }catch{
                print(error)
            }
        }
        
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search restaurants..."
        searchController.searchBar.tintColor = UIColor.whiteColor()
        searchController.searchBar.barTintColor = UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
            case .Insert:
                if let _newIndexPath = newIndexPath {
                    tableView.insertRowsAtIndexPaths([_newIndexPath], withRowAnimation: .Fade)
                }
            case .Delete:
                if let _indexPath = indexPath {
                    tableView.deleteRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
                }
            case .Update:
                if let _indexPath = indexPath {
                    tableView.reloadRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
                }
            default:
                tableView.reloadData()
            }
        
        restaurants = controller.fetchedObjects as! [Restaurant]
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active{
            return searchResults.count
        }else{
           return restaurants.count
        }
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RestaurantTableViewCell
        
        let restaurant = (searchController.active) ? searchResults[indexPath.row] : restaurants[indexPath.row]
        
        cell.nameLabel.text = restaurant.name
        cell.thumbnailImageView.image = UIImage(data: restaurant.image!)
        cell.thumbnailImageView.layer.cornerRadius = 30.0
        cell.thumbnailImageView.clipsToBounds = true
        cell.typeLabel.text = restaurant.type
        cell.locationLabel.text = restaurant.location
        
        if let isVisited = restaurant.isVisited?.boolValue {
            cell.accessoryType = isVisited ? .Checkmark : .None
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if searchController.active{
            return false
        }else{
            return true
        }
    }
    

    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {

        let shareAction = UITableViewRowAction(style:UITableViewRowActionStyle.Default, title: "Share", handler: { (action,
                indexPath) -> Void in
                let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name
                if let imageToShare = UIImage(data:self.restaurants[indexPath.row].image!) {
                    let activityController = UIActivityViewController(activityItems:[defaultText, imageToShare],applicationActivities: nil)
                    self.presentViewController(activityController, animated: true,
                        completion: nil)
                } })
        
        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete") { (action, indexPath) in
            //self.restaurants.removeAtIndex(indexPath.row)
            //self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
                let restaurantToDelete = self.fetchResultController.objectAtIndexPath(indexPath) as! Restaurant
                
                managedObjectContext.deleteObject(restaurantToDelete)
                
                do{
                    try managedObjectContext.save()
                }catch{
                    print(error)
                }
                
            }
        }
        
        shareAction.backgroundColor = UIColor(red: 28.0/255.0, green: 165.0/255.0,blue: 253.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        return [deleteAction, shareAction]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRestaurantDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destinationViewController as! RestaurantDetailViewController
                //destinationController.restaurant = restaurants[indexPath.row]
                destinationController.restaurant = (searchController.active) ?
                    searchResults[indexPath.row] : restaurants[indexPath.row]
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            let fetchRequest = NSFetchRequest(entityName: "Restaurant")
            
            do{
                restaurants = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Restaurant]
                tableView.reloadData()
            }catch{
                print(error)
            }
        }
        
        navigationController?.hidesBarsOnSwipe = true
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let hasViewedWalkthrough = defaults.boolForKey("hasViewedWalkthrough")
        
        if hasViewedWalkthrough {
            return
        }
        
        if let pageViewController = storyboard?.instantiateViewControllerWithIdentifier("WalkthroughController")
            as? WalkthroughPageViewController{
            presentViewController(pageViewController, animated: true, completion: nil)
        }
    }
    
    func filterContentForSearchText(searchText:String){
        searchResults = restaurants.filter({
            (restaurant:Restaurant) -> Bool in
            
            let nameMatch = restaurant.name
                .rangeOfString(searchText,
                               options: NSStringCompareOptions.CaseInsensitiveSearch)
            
            let locationMatch = restaurant.location
                .rangeOfString(searchText,
                    options: NSStringCompareOptions.CaseInsensitiveSearch)
            
            return (nameMatch != nil || locationMatch != nil)
        })
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            filterContentForSearchText(searchText)
            tableView.reloadData()
        }
    }
    
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue){
        
    }
}
