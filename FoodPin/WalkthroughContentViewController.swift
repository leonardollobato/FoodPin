//
//  WalkthroughContentViewController.swift
//  FoodPin
//
//  Created by Leonardo Lobato on 5/31/16.
//  Copyright © 2016 Leonardo Lobato. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {

    @IBOutlet var headingLabel:UILabel!
    @IBOutlet var contentLabel:UILabel!
    @IBOutlet var contentImageView:UIImageView!
    @IBOutlet var pageControl:UIPageControl!
    
    @IBOutlet var fowardButton:UIButton!
    
    var index = 0
    var heading = ""
    var imageFile = ""
    var content = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch index {
            case 0...1: fowardButton.setTitle("NEXT", forState: .Normal)
            case 2: fowardButton.setTitle("DONE", forState: .Normal)
            default: break
        }
        headingLabel.text = heading
        contentLabel.text = content
        contentImageView.image = UIImage(named: imageFile)
        pageControl.currentPage = index
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButtonTaped(sender:UIButton){
        switch index {
        case 0...1:
            let pageViewController = parentViewController as! WalkthroughPageViewController
            pageViewController.forward(index)
        case 2:
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(true, forKey: "hasViewedWalkthrough")
            
            dismissViewControllerAnimated(true, completion: nil)
        default:
            break
        }
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
