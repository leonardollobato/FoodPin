//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Leonardo Lobato on 5/19/16.
//  Copyright © 2016 Leonardo Lobato. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet var backgroundImageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        let blurEffect = UIBlurEffect(style: .Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.userInteractionEnabled = false
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
    
    }
    
    
}
