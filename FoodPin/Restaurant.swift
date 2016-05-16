//
//  Restaurant.swift
//  FoodPin
//
//  Created by Leonardo Lobato on 5/16/16.
//  Copyright © 2016 Leonardo Lobato. All rights reserved.
//

import Foundation

class Restaurant{
    internal var name = ""
    var location = ""
    var type = ""
    var image = ""
    var isVisited = false
    init(name:String, type:String,location:String, image:String, isVisited:Bool){
        self.name = name
        self.location = location
        self.type = type
        self.image = image
        self.isVisited = isVisited
    }
}