//
//  AboutTableViewController.swift
//  FoodPin
//
//  Created by Leonardo Lobato on 6/3/16.
//  Copyright © 2016 Leonardo Lobato. All rights reserved.
//

import UIKit
import SafariServices

class AboutTableViewController: UITableViewController {
    
    var sectionTitles = ["Leave Feedback", "Follow Us"]
    
    var sectionContent = [
                          ["Rate us on App Store","Tell us your feedback"],
                          ["Twitter", "Facebook", "Pinterest"]
                         ]
    
    var links = ["https://twitter.com/appcodamobile",
                 "https://facebook.com/appcodamobile",
                 "https://www.pinterest.com/appcoda/"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if section == 0 {
            return 2
        }else{
            return 3
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "Cell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        
        cell.textLabel?.text  = sectionContent[indexPath.section][indexPath.row]
        
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                if let url = NSURL(string: "http://www.apple.com/itunes/charts/paid-apps/"){
                    UIApplication.sharedApplication().openURL(url)
                }
            }else if indexPath.row == 1{
                performSegueWithIdentifier("showWebView", sender: self)
            }
        case 1:
            if let url = NSURL(string: links[indexPath.row]){
                let safariController = SFSafariViewController(URL: url, entersReaderIfAvailable: true)
                presentViewController(safariController, animated: true, completion: nil)
            }
        default:
            break
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

}
