//
//  RestaurantTableViewCell.swift
//  FoodPin
//
//  Created by Leonardo Lobato on 5/12/16.
//  Copyright © 2016 Leonardo Lobato. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var typeLabel:UILabel!
    @IBOutlet var locationLabel:UILabel!
    @IBOutlet var thumbnailImageView:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
