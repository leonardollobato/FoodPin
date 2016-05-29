//
//  AddRestaurantController.swift
//  FoodPin
//
//  Created by Leonardo Lobato on 5/21/16.
//  Copyright © 2016 Leonardo Lobato. All rights reserved.
//

import UIKit

class AddRestaurantController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var nameTextField:UITextField!
    @IBOutlet var typeTextField:UITextField!
    @IBOutlet var locationTextField:UITextField!
    
    @IBOutlet var yesButton:UIButton!
    @IBOutlet var noButton:UIButton!
    
    
    var hasVisited = true
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                let imagePicker = UIImagePickerController()
                
                imagePicker.delegate = self
                
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .PhotoLibrary
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    @IBAction func toogleHaveYouBeen(sender:UIButton!){
        
        if sender.currentTitle! == "YES" {
            hasVisited = true
            yesButton.backgroundColor = UIColor.redColor()
            noButton.backgroundColor = UIColor.grayColor()
        }else{
            hasVisited = false
            yesButton.backgroundColor = UIColor.grayColor()
            noButton.backgroundColor = UIColor.redColor()
        }
    }
    
    @IBAction func saveRestaurant(sender:UIButton){

        if (nameTextField.text! == ""   ||
            locationTextField.text! == ""   ||
            typeTextField.text! == "" ){
            
            var message = "O(s) campo(s):\n"
            
            if nameTextField.text! == "" {
                message.appendContentsOf("\nField Name")
            }
            
            if locationTextField.text! == "" {
                message.appendContentsOf("\nField Location")
            }
            
            if typeTextField.text! == "" {
                message.appendContentsOf("\nField Type")
            }
            
            message.appendContentsOf("\n\n foram deixados em branco, por favor preenche-los")
            
            
            let alert = UIAlertController(title: "Aviso", message: message, preferredStyle: .Alert)
            let okay = UIAlertAction(title: "OK", style: .Default, handler: nil)
            
            alert.addAction(okay)
            presentViewController(alert, animated: true, completion: nil)
            
        }else{
            
        
            print("Name: \(self.nameTextField.text!)")
            print("Type: \(self.typeTextField.text!)")
            print("Location: \(self.locationTextField.text!)")
            print("Has Been?: " + (self.hasVisited ? "YEP" : "NOPE"))
            
            performSegueWithIdentifier("unwindToHomeScreen", sender: self)
            
            //dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        
        let leadingConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        leadingConstraint.active = true
        
        let trailingConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: imageView.superview, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
        
        trailingConstraint.active = true
        
        let topConstraint = NSLayoutConstraint(item: imageView, attribute: .Top, relatedBy: .Equal, toItem: imageView.superview, attribute: .Top, multiplier: 1, constant: 0)
        topConstraint.active = true
        
        let bottomConstraint = NSLayoutConstraint(item: imageView, attribute: .Bottom, relatedBy: .Equal, toItem: imageView.superview, attribute: .Bottom, multiplier: 1, constant: 0)
        bottomConstraint.active = true
        
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}
