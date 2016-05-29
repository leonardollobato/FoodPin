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
    @IBOutlet var dislike:UIButton!
    @IBOutlet var good:UIButton!
    @IBOutlet var great:UIButton!
    var rating:String?
    var bgImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        backgroundImageView.image = bgImage!
      
        let blurEffect = UIBlurEffect(style: .Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.userInteractionEnabled = false
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        let scaleDis = CGAffineTransformMakeScale(0.0, 0.0)
        let translateDis = CGAffineTransformMakeTranslation(0, 500)
        dislike.transform = CGAffineTransformConcat(scaleDis, translateDis)
        let scaleGood = CGAffineTransformMakeScale(0.0, 0.0)
        let translateGood = CGAffineTransformMakeTranslation(0, 1000)
        good.transform = CGAffineTransformConcat(scaleGood, translateGood)
        let scaleGreat = CGAffineTransformMakeScale(0.0, 0.0)
        let translateGreat = CGAffineTransformMakeTranslation(0, 1500)
        great.transform = CGAffineTransformConcat(scaleGreat, translateGreat)
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.4, delay: 0.0, options: [], animations: {
            self.dislike.transform = CGAffineTransformIdentity
            self.good.transform = CGAffineTransformIdentity
            self.great.transform = CGAffineTransformIdentity
            }, completion: nil)
    }
    
    @IBAction func ratingSelected(sender:UIButton){
        switch(sender.tag){
            case 100: rating = "dislike"
            case 200: rating = "good"
            case 300: rating = "great"
            default:break
        }
        
        performSegueWithIdentifier("unwindToDetailView", sender: sender)
    }
    
    
}
