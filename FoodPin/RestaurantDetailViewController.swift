//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Leonardo Lobato on 5/16/16.
//  Copyright © 2016 Leonardo Lobato. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    @IBOutlet var restaurantImageView:UIImageView!
    @IBOutlet var restaurantName:UILabel!
    @IBOutlet var restaurantType:UILabel!
    @IBOutlet var restaurantLocation:UILabel!
    var restaurant:Restaurant!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantImageView.image = UIImage(named: restaurant.image)
        restaurantName.text = restaurant.name
        restaurantType.text = restaurant.type
        restaurantLocation.text = restaurant.location


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
