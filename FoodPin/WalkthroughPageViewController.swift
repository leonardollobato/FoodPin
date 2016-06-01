//
//  WalkthroughPageViewController.swift
//  FoodPin
//
//  Created by Leonardo Lobato on 5/31/16.
//  Copyright © 2016 Leonardo Lobato. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var pageHeadings = ["Personalize", "Locate", "Discover"]
    var pageImages = ["foodpin-intro-1", "foodpin-intro-2", "foodpin-intro-3"]
    var pageContent = ["Pin your favorite restaurants and create your own food guide",
    "Search and locate your favourite restaurant on Maps",
    "Find restaurants pinned by your friends and other foodies around the world"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let startingViewController = viewControllerAtIndex(0) {
            setViewControllers([ startingViewController], direction: .Forward, animated: true, completion: nil)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        
        return viewControllerAtIndex(index)
    }
    
//    @IBAction func close(sender:AnyObject){
//        let defaults = NSUserDefaults.standardUserDefaults()
//        defaults.setBool(true, forKey: "hasViewedWalkthrough")
//        
//        dismissViewControllerAnimated(true, completion: nil)
//    }
    
//    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return pageHeadings.count
//    }
//    
//    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//        if let pageContentViewController = storyboard?.instantiateViewControllerWithIdentifier("WalkthroughContentViewController")
//            as? WalkthroughContentViewController{
//            return pageContentViewController.index
//        }
//        
//        return 0
//    }
    func forward(index:Int){
        if let nextViewController = viewControllerAtIndex(index + 1){
            setViewControllers([nextViewController], direction: .Forward, animated: true, completion: nil)
        }
    }
    func viewControllerAtIndex(index:Int) -> WalkthroughContentViewController? {
        if index == NSNotFound || index < 0 || index >= pageHeadings.count {
            return nil
        }
        
        if let pageContentViewController =
            storyboard?.instantiateViewControllerWithIdentifier("WalkthroughContentViewController")
                as? WalkthroughContentViewController{
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.content = pageContent[index]
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        
        return nil
    }

}
