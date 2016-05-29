//
//  Restaurant.swift
//  FoodPin
//
//  Created by Leonardo Lobato on 5/16/16.
//  Copyright © 2016 Leonardo Lobato. All rights reserved.
//

import Foundation
import CoreData

class Restaurant:NSManagedObject{
    @NSManaged var name:String
    @NSManaged var location:String
    @NSManaged var type:String
    @NSManaged var image:NSData?
    @NSManaged var isVisited:NSNumber?
    @NSManaged var phoneNumber:String?
    @NSManaged var rating:String?

}